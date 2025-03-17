import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:local_notification/services/firebase_message_service.dart';

import 'home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //INITIALIZE FIREBASE
  await Firebase.initializeApp();

  //INITIALIZE FIREBASE MESSAGING SERVICE
  await FirebaseMessageService().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Local Notification',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}