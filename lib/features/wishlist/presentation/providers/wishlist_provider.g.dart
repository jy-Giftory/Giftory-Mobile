part of 'wishlist_provider.dart';

String _$wishlistNotifierHash() => r'78f884a092ca23da4af919824510a630bc4b1214';

@ProviderFor(WishlistNotifier)
final wishlistNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      WishlistNotifier,
      List<GiftRecommendation>
    >.internal(
      WishlistNotifier.new,
      name: r'wishlistNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$wishlistNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$WishlistNotifier = AutoDisposeAsyncNotifier<List<GiftRecommendation>>;