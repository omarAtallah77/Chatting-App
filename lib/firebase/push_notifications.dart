import 'package:firebase_messaging/firebase_messaging.dart';
class notification {
  Future<String?> getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    await messaging.requestPermission();
    final token = await messaging.getToken();
    print( "FCM Token: $token"); // Store this token in your Firestore database associated with the user
    return token;
  }
void handle_message(RemoteMessage ? message) {
    if (message == null) return ;
}
}