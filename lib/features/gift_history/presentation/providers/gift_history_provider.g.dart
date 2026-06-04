part of 'gift_history_provider.dart';

String _$giftHistoryDatasourceHash() =>
    r'8bdf0290b3fe7972f6d4b8a6e841d7b1f2a1f2ae';

@ProviderFor(giftHistoryDatasource)
final giftHistoryDatasourceProvider =
    AutoDisposeProvider<GiftHistoryDatasource>.internal(
      giftHistoryDatasource,
      name: r'giftHistoryDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftHistoryDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
typedef GiftHistoryDatasourceRef =
    AutoDisposeProviderRef<GiftHistoryDatasource>;
String _$giftHistoryRepositoryHash() =>
    r'70ba5079e13ace4bd29b1faf9ccf48daeda2c049';

@ProviderFor(giftHistoryRepository)
final giftHistoryRepositoryProvider =
    AutoDisposeProvider<GiftHistoryRepositoryImpl>.internal(
      giftHistoryRepository,
      name: r'giftHistoryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftHistoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
typedef GiftHistoryRepositoryRef =
    AutoDisposeProviderRef<GiftHistoryRepositoryImpl>;
String _$giftHistoryNotifierHash() =>
    r'aba66ec6a2028318a4eaa8a17cfc1c6704a163e3';

@ProviderFor(GiftHistoryNotifier)
final giftHistoryNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      GiftHistoryNotifier,
      List<GiftHistory>
    >.internal(
      GiftHistoryNotifier.new,
      name: r'giftHistoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GiftHistoryNotifier = AutoDisposeAsyncNotifier<List<GiftHistory>>;
