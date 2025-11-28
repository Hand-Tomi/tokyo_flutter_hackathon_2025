import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration for accessing API keys and other secrets.
///
/// Usage:
/// ```dart
/// final apiKey = EnvConfig.openAiApiKey;
/// ```
class EnvConfig {
  EnvConfig._();

  /// OpenAI API Key for AI services.
  /// Set this in apps/mobile/.env file:
  /// ```
  /// OPENAI_API_KEY=your_openai_api_key_here
  /// ```
  static String get openAiApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';

  /// Check if OpenAI API key is configured.
  static bool get hasOpenAiApiKey => openAiApiKey.isNotEmpty;
}
