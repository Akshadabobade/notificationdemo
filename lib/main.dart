import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/auth_page.dart';
import 'package:local_notification/services/firebase_message_service.dart';

import 'home_page.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  // 1.INITIALIZE FIREBASE
  await Firebase.initializeApp();

  // 2.INITIALIZE FIREBASE MESSAGING SERVICE
  await FirebaseMessageService().init();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Notification',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: AuthPage(),
    );
  }
}