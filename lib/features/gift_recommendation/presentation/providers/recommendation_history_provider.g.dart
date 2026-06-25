part of 'recommendation_history_provider.dart';

String _$recommendationHistoryNotifierHash() =>
    r'1123a0504d0587f374498f1a6c25f1bfa94cced0';

@ProviderFor(RecommendationHistoryNotifier)
final recommendationHistoryNotifierProvider =
    AutoDisposeAsyncNotifierProvider<
      RecommendationHistoryNotifier,
      List<RecommendationRecord>
    >.internal(
      RecommendationHistoryNotifier.new,
      name: r'recommendationHistoryNotifierProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$recommendationHistoryNotifierHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$RecommendationHistoryNotifier =
    AutoDisposeAsyncNotifier<List<RecommendationRecord>>;