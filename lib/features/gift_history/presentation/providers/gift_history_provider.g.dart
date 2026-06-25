part of 'gift_history_provider.dart';

String _$giftHistoryDatasourceHash() =>
    r'98c0fae3f442aadc73714aff39420e7a762dafd6';

@ProviderFor(giftHistoryDatasource)
final giftHistoryDatasourceProvider = Provider<GiftHistoryDatasource>.internal(
  giftHistoryDatasource,
  name: r'giftHistoryDatasourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$giftHistoryDatasourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
typedef GiftHistoryDatasourceRef = ProviderRef<GiftHistoryDatasource>;
String _$giftHistoryRepositoryHash() =>
    r'a277a7e8d07b20fa1929b9e588627de717ddb8cd';

@ProviderFor(giftHistoryRepository)
final giftHistoryRepositoryProvider =
    Provider<GiftHistoryRepositoryImpl>.internal(
      giftHistoryRepository,
      name: r'giftHistoryRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftHistoryRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
typedef GiftHistoryRepositoryRef = ProviderRef<GiftHistoryRepositoryImpl>;
String _$giftHistoryNotifierHash() =>
    r'b03ebff0967809862ad1459e81ae22b5a419e97a';

@ProviderFor(GiftHistoryNotifier)
final giftHistoryNotifierProvider =
    AsyncNotifierProvider<GiftHistoryNotifier, List<GiftHistory>>.internal(
      GiftHistoryNotifier.new,
      name: r'giftHistoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GiftHistoryNotifier = AsyncNotifier<List<GiftHistory>>;