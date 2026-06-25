part of 'gift_recommendation_provider.dart';

String _$giftRecommendationFormHash() =>
    r'5d1554d0d8c2961254ca9fe51afe025fbc3fd907';

@ProviderFor(GiftRecommendationForm)
final giftRecommendationFormProvider =
    AutoDisposeNotifierProvider<
      GiftRecommendationForm,
      GiftRecommendationFormState
    >.internal(
      GiftRecommendationForm.new,
      name: r'giftRecommendationFormProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftRecommendationFormHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GiftRecommendationForm =
    AutoDisposeNotifier<GiftRecommendationFormState>;
String _$giftRecommendationResultHash() =>
    r'94a13223993221ca248da637a16f571c2cae6f11';

@ProviderFor(GiftRecommendationResult)
final giftRecommendationResultProvider =
    AutoDisposeNotifierProvider<
      GiftRecommendationResult,
      AsyncValue<GiftRecommendationResultData?>
    >.internal(
      GiftRecommendationResult.new,
      name: r'giftRecommendationResultProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$giftRecommendationResultHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$GiftRecommendationResult =
    AutoDisposeNotifier<AsyncValue<GiftRecommendationResultData?>>;