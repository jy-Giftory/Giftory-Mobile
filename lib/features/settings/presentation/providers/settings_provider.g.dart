part of 'settings_provider.dart';

String _$settingsNotifierHash() => r'7de1f8c7b5b33a4bf4ccb7f9680faabd5f49a697';

@ProviderFor(SettingsNotifier)
final settingsNotifierProvider =
    AutoDisposeNotifierProvider<SettingsNotifier, AppSettings>.internal(
      SettingsNotifier.new,
      name: r'settingsNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$settingsNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SettingsNotifier = AutoDisposeNotifier<AppSettings>;
