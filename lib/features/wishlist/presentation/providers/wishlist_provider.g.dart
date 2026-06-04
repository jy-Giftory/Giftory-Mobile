part of 'wishlist_provider.dart';

String _$wishlistNotifierHash() => r'730f2df9b5931c91a38ce532a32d9721bd8b0972';

@ProviderFor(WishlistNotifier)
final wishlistNotifierProvider =
    AutoDisposeNotifierProvider<
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

typedef _$WishlistNotifier = AutoDisposeNotifier<List<GiftRecommendation>>;