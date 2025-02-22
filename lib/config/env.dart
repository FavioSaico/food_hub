import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  
  static String apiKey = dotenv.env['API_KEY_STACK_AI'] ?? '';
  static String orgId = dotenv.env['ORG_ID_STACK_AI'] ?? '';
  static String tabId = dotenv.env['TAB_ID_STACK_AI'] ?? '';
}