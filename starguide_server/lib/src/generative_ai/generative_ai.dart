import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:serverpod/serverpod.dart';
import 'package:starguide_server/src/extensions/chat_message_to_role.dart';
import 'package:starguide_server/src/generated/protocol.dart';

class GenerativeAi {
  final String geminiAPIKey;
  late Agent agent;

  GenerativeAi()
      : geminiAPIKey = Serverpod.instance.getPassword('geminiAPIKey')! {
    agent = Agent.provider(GeminiProvider(apiKey: geminiAPIKey));
  }

  Stream<String> generateConversationalAnswer({
    required String question,
    required String systemPrompt,
    List<RAGDocument> documents = const [],
    List<ChatMessage> conversation = const [],
  }) async* {
    final messages = <Message>[];

    // Add conversation history
    for (final chatMessage in conversation) {
      messages.add(Message(
        role: chatMessage.type.aiRole == 'user'
            ? MessageRole.user
            : MessageRole.model,
        content: [TextPart(chatMessage.message)],
      ));
    }

    final fullSystemPrompt =
        systemPrompt + documents.map((e) => _formatDocument(e)).join('\n');
    final agentWithSystem = Agent.provider(
      GeminiProvider(apiKey: geminiAPIKey),
      systemPrompt: fullSystemPrompt,
    );

    final response = agentWithSystem.runStream(question, messages: messages);
    await for (final chunk in response) {
      yield chunk.output;
    }
  }

  Future<String> generateSimpleAnswer(String question) async {
    final response = await agent.run(question);
    return response.output;
  }

  Future<Vector> generateEmbedding(String document) async {
    final embedding = await agent.createEmbedding(document);
    return Vector(embedding.toList());
  }

  String _formatDocument(RAGDocument document) {
    return '<doc href="${document.sourceUrl}">\n${document.content}\n</doc>';
  }
}
