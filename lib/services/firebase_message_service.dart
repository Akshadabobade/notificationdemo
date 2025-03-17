import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:local_notification/services/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
print('handling background message');
}



class FirebaseMessageService {

  //1. CREATE PRIVATE INSTANCE
  static final FirebaseMessageService _instance = FirebaseMessageService.internal();


  //2. FACTORY METHOD

factory FirebaseMessageService(){
  return _instance;
}

//3. CONSTRUCTOR

FirebaseMessageService.internal();

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
final NotificationService _notificationService= NotificationService();

Future<void> init() async {

  //1. GET FCM TOKEN

  String? token =  await _firebaseMessaging.getToken();
  print("Token :$token");

  //CONFIGURE MESSAGE HANDLING
  FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

 // FirebaseMessaging.onMessageOpenedApp.listen();

 // FirebaseMessaging.onBackgroundMessage();
}

void _handleForegroundMessage(RemoteMessage message){
  print(message);

  print(message.notification?.title);
  print(message.notification?.body);
  
  _notificationService.sendInstanceNotification(
      title: message.notification?.title ?? '',
      description: message.notification?.body ?? ''

  );
}
}