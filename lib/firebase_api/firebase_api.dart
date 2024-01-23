import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseApi {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print("Tokenfirebase: $fCMToken");
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }

  Future<String?> getFCMToken() async {
    // Return the FCM token
    return await _firebaseMessaging.getToken();
  }
}

// Define the function to handle background messages
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}
