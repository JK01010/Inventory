import 'package:receive_intent/receive_intent.dart';

class IntentService {
  Future<Map<String, dynamic>?> getInitialIntentData() async {
    final intent = await ReceiveIntent.getInitialIntent();
    return intent?.extra;
  }
}