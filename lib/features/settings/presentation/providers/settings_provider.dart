import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/settings/domain/entities/app_settings.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  static const _boxKey = 'app_settings';
  static const _dataKey = 'data';

  Box get _box => Hive.box(_boxKey);

  @override
  AppSettings build() {
    final raw = _box.get(_dataKey) as String?;
    if (raw == null) return const AppSettings();
    return AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  void update(AppSettings settings) {
    state = settings;
    _box.put(_dataKey, jsonEncode(settings.toJson()));
  }
}
