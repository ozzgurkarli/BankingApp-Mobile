import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:parbank/UI/S-SPLSHSCR/SPLSHSCR.dart';
import 'package:parbank/api/ENV.dart';
import 'package:parbank/api/IService.dart';
import 'package:parbank/api/UProxy.dart';
import 'package:parbank/api/URequestTypes.dart';
import 'package:parbank/dto/MessageContainer.dart';
import 'package:parbank/helpers/USize.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  await _firebaseMessaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  if (Platform.isIOS) {
    try {
      String? apnsToken = await _firebaseMessaging.getAPNSToken();
      if (apnsToken != null) {
        await _firebaseMessaging.getToken().then((value) {
          ENV.NotificationToken = value;
        });
      } else {
        await Future<void>.delayed(
          const Duration(
            seconds: 3,
          ),
        );
        apnsToken = await _firebaseMessaging.getAPNSToken();
        if (apnsToken != null) {
          await _firebaseMessaging.getToken().then((value) {
            ENV.NotificationToken = value;
          });
        }
      }
    } catch (e) {}
  } else {
    await _firebaseMessaging.getToken().then((value) {
      ENV.NotificationToken = value;
    });
  }

  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

  _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {}
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void handleMessage(RemoteMessage? message) {
  if (message == null) {
    return;
  }

  ENV.NotificationMessage = message;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    USize.Height = MediaQuery.of(context).size.height - kToolbarHeight;
    USize.Width = MediaQuery.of(context).size.width;

    UProxy.Request(
        URequestTypes.GET, IService.TRIGGER_SCHEDULES, MessageContainer());

    return MaterialApp(
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
              TargetPlatform.iOS: OpenUpwardsPageTransitionsBuilder()
            }),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SPLSHSCR(),
    );
  }
}
