import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:giftory/app.dart';
import 'package:giftory/core/services/notification_service.dart';
import 'package:giftory/core/services/widget_service.dart';
import 'package:giftory/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('auth'),
    Hive.openBox('app_settings'),
  ]);

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermission();

  await WidgetService.instance.init();

  runApp(
    const ProviderScope(
      child: GiftoryApp(),
    ),
  );
}
