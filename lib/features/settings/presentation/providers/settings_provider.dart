import 'dart:convert';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/core/network/dio_client.dart';
import 'package:giftory/core/network/token_storage.dart';
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
    final local = raw == null
        ? const AppSettings()
        : AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);

    if (TokenStorage.instance.isLoggedIn) {
      _syncFromServer();
    }
    return local;
  }

  void update(AppSettings settings) {
    state = settings;
    _persistLocal(settings);
    _pushToServer(settings);
  }

  Future<void> _syncFromServer() async {
    try {
      final res = await ref.read(dioProvider).get('/settings');
      if (res.statusCode == 200) {
        final server = _fromServer(res.data as Map<String, dynamic>);
        state = server;
        _persistLocal(server);
      }
    } catch (_) {
    }
  }

  Future<void> _pushToServer(AppSettings s) async {
    if (!TokenStorage.instance.isLoggedIn) return;
    try {
      await ref.read(dioProvider).post('/settings', data: _toServer(s));
    } catch (_) {}
  }

  void _persistLocal(AppSettings s) {
    _box.put(_dataKey, jsonEncode(s.toJson()));
  }

  AppSettings _fromServer(Map<String, dynamic> d) => AppSettings(
        notifyMonthBefore: d['notifyMonthly'] as bool? ?? true,
        notifyTwoWeeksBefore: d['notifyTwoWeeks'] as bool? ?? true,
        notifyDayBefore: d['notifyOneDay'] as bool? ?? true,
        notifyOnDay: d['notifyDDay'] as bool? ?? true,
        emailNotification: d['emailNotification'] as bool? ?? false,
        themeType: d['theme'] == 'OLIVE' ? ThemeType.olive : ThemeType.moca,
      );

  Map<String, dynamic> _toServer(AppSettings s) => {
        'notifyMonthly': s.notifyMonthBefore,
        'notifyTwoWeeks': s.notifyTwoWeeksBefore,
        'notifyOneDay': s.notifyDayBefore,
        'notifyDDay': s.notifyOnDay,
        'emailNotification': s.emailNotification,
        'theme': s.themeType == ThemeType.olive ? 'OLIVE' : 'MOCA',
      };
}
