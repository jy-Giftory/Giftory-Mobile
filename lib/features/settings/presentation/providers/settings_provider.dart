import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/settings/domain/entities/app_settings.dart';

part 'settings_provider.g.dart';

@riverpod
class SettingsNotifier extends _$SettingsNotifier {
  @override
  AppSettings build() => const AppSettings();

  void update(AppSettings settings) => state = settings;
}
