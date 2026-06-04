// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gift_history_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$giftHistoryDatasourceHash() =>
    r'0f25cbffd17fc88cb544950163957a61530ccd46';

/// See also [giftHistoryDatasource].
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
// ignore: unused_element
typedef GiftHistoryDatasourceRef = ProviderRef<GiftHistoryDatasource>;
String _$giftHistoryRepositoryHash() =>
    r'a277a7e8d07b20fa1929b9e588627de717ddb8cd';

/// See also [giftHistoryRepository].
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
// ignore: unused_element
typedef GiftHistoryRepositoryRef = ProviderRef<GiftHistoryRepositoryImpl>;
String _$giftHistoryNotifierHash() =>
    r'b03ebff0967809862ad1459e81ae22b5a419e97a';

/// See also [GiftHistoryNotifier].
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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
