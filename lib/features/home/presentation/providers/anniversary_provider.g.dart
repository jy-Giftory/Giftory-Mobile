part of 'anniversary_provider.dart';

String _$anniversaryDatasourceHash() =>
    r'36eaa719467eaf1c7c0a2325166b737d60bb91ab';

@ProviderFor(anniversaryDatasource)
final anniversaryDatasourceProvider =
    AutoDisposeProvider<AnniversaryDatasource>.internal(
      anniversaryDatasource,
      name: r'anniversaryDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$anniversaryDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
typedef AnniversaryDatasourceRef =
    AutoDisposeProviderRef<AnniversaryDatasource>;
String _$anniversaryRepositoryHash() =>
    r'45340ad3d54ac62162586d6ae28b860a1bfe95e4';

@ProviderFor(anniversaryRepository)
final anniversaryRepositoryProvider =
    AutoDisposeProvider<AnniversaryRepositoryImpl>.internal(
      anniversaryRepository,
      name: r'anniversaryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$anniversaryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
typedef AnniversaryRepositoryRef =
    AutoDisposeProviderRef<AnniversaryRepositoryImpl>;
String _$anniversaryNotifierHash() =>
    r'69710e6a06b89bb7e15aca18509a82ce1d109b0f';

@ProviderFor(AnniversaryNotifier)
final anniversaryNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      AnniversaryNotifier,
      List<Anniversary>
    >.internal(
      AnniversaryNotifier.new,
      name: r'anniversaryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$anniversaryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$AnniversaryNotifier = AutoDisposeAsyncNotifier<List<Anniversary>>;
String _$selectedDayHash() => r'8c6e652ff97cc8b64d348b03403e599ba425b591';

@ProviderFor(SelectedDay)
final selectedDayProvider =
    AutoDisposeNotifierProvider<SelectedDay, DateTime>.internal(
      SelectedDay.new,
      name: r'selectedDayProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$selectedDayHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SelectedDay = AutoDisposeNotifier<DateTime>;
String _$focusedMonthHash() => r'5e2f423868abba3060fcdff7b3bb80afc7f445fe';

@ProviderFor(FocusedMonth)
final focusedMonthProvider =
    AutoDisposeNotifierProvider<FocusedMonth, DateTime>.internal(
      FocusedMonth.new,
      name: r'focusedMonthProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$focusedMonthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FocusedMonth = AutoDisposeNotifier<DateTime>;
