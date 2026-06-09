import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/gift_recommendation/data/datasources/gift_recommendation_datasource.dart';
import 'package:giftory/features/gift_recommendation/data/repositories/gift_recommendation_repository_impl.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/age_group.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gender_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation_request.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/occasion_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/personality_type.dart';
import 'package:giftory/features/gift_recommendation/domain/usecases/get_gift_recommendations_usecase.dart';

part 'gift_recommendation_provider.g.dart';

class GiftRecommendationFormState {
  final String recipient;
  final AgeGroup? ageGroup;
  final GenderType? gender;
  final int minBudget;
  final int maxBudget;
  final Set<String> selectedMainCategories;
  final Map<String, Set<String>> selectedSubCategories;
  final String customInterest;
  final Set<PersonalityType> personalities;
  final Set<OccasionType> occasions;
  final String customOccasion;
  final String memo;

  const GiftRecommendationFormState({
    this.recipient = '',
    this.ageGroup,
    this.gender,
    this.minBudget = 5000,
    this.maxBudget = 30000,
    this.selectedMainCategories = const {},
    this.selectedSubCategories = const {},
    this.customInterest = '',
    this.personalities = const {},
    this.occasions = const {},
    this.customOccasion = '',
    this.memo = '',
  });

  bool get isValid => recipient.isNotEmpty && selectedMainCategories.isNotEmpty;

  GiftRecommendationFormState copyWith({
    String? recipient,
    AgeGroup? ageGroup,
    GenderType? gender,
    int? minBudget,
    int? maxBudget,
    Set<String>? selectedMainCategories,
    Map<String, Set<String>>? selectedSubCategories,
    String? customInterest,
    Set<PersonalityType>? personalities,
    Set<OccasionType>? occasions,
    String? customOccasion,
    String? memo,
  }) {
    return GiftRecommendationFormState(
      recipient: recipient ?? this.recipient,
      ageGroup: ageGroup ?? this.ageGroup,
      gender: gender ?? this.gender,
      minBudget: minBudget ?? this.minBudget,
      maxBudget: maxBudget ?? this.maxBudget,
      selectedMainCategories: selectedMainCategories ?? this.selectedMainCategories,
      selectedSubCategories: selectedSubCategories ?? this.selectedSubCategories,
      customInterest: customInterest ?? this.customInterest,
      personalities: personalities ?? this.personalities,
      occasions: occasions ?? this.occasions,
      customOccasion: customOccasion ?? this.customOccasion,
      memo: memo ?? this.memo,
    );
  }

  GiftRecommendationRequest toRequest() => GiftRecommendationRequest(
        recipient: recipient,
        ageGroup: ageGroup,
        gender: gender,
        minBudget: minBudget,
        maxBudget: maxBudget,
        selectedMainCategories: selectedMainCategories,
        selectedSubCategories: selectedSubCategories,
        customInterest: customInterest.isEmpty ? null : customInterest,
        personalities: personalities,
        occasions: occasions,
        customOccasion: customOccasion.isEmpty ? null : customOccasion,
        memo: memo.isEmpty ? null : memo,
      );
}

class GiftRecommendationResultData {
  final String subtitle;
  final List<GiftRecommendation> items;
  final String congratsMessage;
  final SortOption sortOption;

  const GiftRecommendationResultData({
    required this.subtitle,
    required this.items,
    required this.congratsMessage,
    this.sortOption = SortOption.basic,
  });

  List<GiftRecommendation> get sortedItems {
    final list = [...items];
    switch (sortOption) {
      case SortOption.basic:
        return list;
      case SortOption.priceLow:
        return list..sort((a, b) => a.price.compareTo(b.price));
      case SortOption.priceHigh:
        return list..sort((a, b) => b.price.compareTo(a.price));
      case SortOption.popularity:
      case SortOption.review:
        return list;
    }
  }
}

enum SortOption {
  basic,
  priceLow,
  priceHigh,
  popularity,
  review,
}

extension SortOptionX on SortOption {
  String get label {
    switch (this) {
      case SortOption.basic:      return '기본';
      case SortOption.priceLow:   return '낮은가격';
      case SortOption.priceHigh:  return '높은가격';
      case SortOption.popularity: return '인기도';
      case SortOption.review:     return '리뷰';
    }
  }
}

@riverpod
class GiftRecommendationForm extends _$GiftRecommendationForm {
  @override
  GiftRecommendationFormState build() => const GiftRecommendationFormState();

  void updateRecipient(String v) =>
      state = state.copyWith(recipient: v);

  void selectAgeGroup(AgeGroup v) =>
      state = state.copyWith(ageGroup: v);

  void selectGender(GenderType v) =>
      state = state.copyWith(gender: v);

  void updateMinBudget(int v) =>
      state = state.copyWith(minBudget: v);

  void updateMaxBudget(int v) =>
      state = state.copyWith(maxBudget: v);

  void toggleMainCategory(String name) {
    final set = Set<String>.from(state.selectedMainCategories);
    if (set.contains(name)) {
      set.remove(name);
      final subs = Map<String, Set<String>>.from(state.selectedSubCategories);
      subs.remove(name);
      state = state.copyWith(
        selectedMainCategories: set,
        selectedSubCategories: subs,
      );
    } else {
      set.add(name);
      state = state.copyWith(selectedMainCategories: set);
    }
  }

  void toggleSubCategory(String mainName, String subName) {
    final subs = Map<String, Set<String>>.from(state.selectedSubCategories);
    final set = Set<String>.from(subs[mainName] ?? {});
    if (set.contains(subName)) {
      set.remove(subName);
    } else {
      set.add(subName);
    }
    subs[mainName] = set;
    state = state.copyWith(selectedSubCategories: subs);
  }

  void updateCustomInterest(String v) =>
      state = state.copyWith(customInterest: v);

  void togglePersonality(PersonalityType v) {
    final set = Set<PersonalityType>.from(state.personalities);
    if (set.contains(v)) {
      set.remove(v);
    } else {
      set.add(v);
    }
    state = state.copyWith(personalities: set);
  }

  void selectOccasion(OccasionType v) {
    final alreadySelected = state.occasions.contains(v);
    state = state.copyWith(occasions: alreadySelected ? {} : {v});
  }

  void updateCustomOccasion(String v) =>
      state = state.copyWith(customOccasion: v);

  void updateMemo(String v) =>
      state = state.copyWith(memo: v);
}

@riverpod
class GiftRecommendationResult extends _$GiftRecommendationResult {
  @override
  AsyncValue<GiftRecommendationResultData?> build() =>
      const AsyncValue.data(null);

  Future<void> fetch(GiftRecommendationRequest request) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final repo = GiftRecommendationRepositoryImpl(
        GiftRecommendationDatasource(),
      );
      final result = await GetGiftRecommendationsUsecase(repo).call(request);
      return GiftRecommendationResultData(
        subtitle: result.subtitle,
        items: result.items,
        congratsMessage: result.congratsMessage,
      );
    });
  }

  void updateSort(SortOption option) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(GiftRecommendationResultData(
      subtitle: current.subtitle,
      items: current.items,
      congratsMessage: current.congratsMessage,
      sortOption: option,
    ));
  }

  void toggleWishlist(String id) {
    final current = state.valueOrNull;
    if (current == null) return;
    final items = current.items.map((item) {
      if (item.id == id) item.isInWishlist = !item.isInWishlist;
      return item;
    }).toList();
    state = AsyncValue.data(GiftRecommendationResultData(
      subtitle: current.subtitle,
      items: items,
      congratsMessage: current.congratsMessage,
      sortOption: current.sortOption,
    ));
  }

  void updateCongratsMessage(String message) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncValue.data(GiftRecommendationResultData(
      subtitle: current.subtitle,
      items: current.items,
      congratsMessage: message,
      sortOption: current.sortOption,
    ));
  }
}
