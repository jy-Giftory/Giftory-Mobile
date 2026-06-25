part of 'anniversary_provider.dart';

String _$anniversaryDatasourceHash() =>
    r'63ccc0848c3daefd72456707abb6f6a16848434c';

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
    r'4c2a77a4b0fa4729d52f9561773dffcd80b3dfb7';

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
    r'9d869af3efbc39dc8621b0d598b0a3ba7e3d9caa';

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
String _$focusedMonthHash() => r'4756259768b79a696b59c2afef9a644ae118c722';

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