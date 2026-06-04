import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:giftory/app.dart';
import 'package:giftory/core/services/notification_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  await Future.wait([
    Hive.openBox('anniversaries'),
    Hive.openBox('gift_histories'),
    Hive.openBox('wishlist'),
    Hive.openBox('app_settings'),
  ]);

  await NotificationService.instance.init();
  await NotificationService.instance.requestPermission();

  runApp(
    const ProviderScope(
      child: GiftoryApp(),
    ),
  );
}
