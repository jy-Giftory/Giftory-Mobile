import 'package:giftory/features/gift_recommendation/domain/entities/age_group.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gender_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/occasion_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/personality_type.dart';

class GiftRecommendationRequest {
  final String recipient;
  final AgeGroup? ageGroup;
  final GenderType? gender;
  final int minBudget;
  final int maxBudget;
  final Set<String> selectedMainCategories;
  final Map<String, Set<String>> selectedSubCategories;
  final String? customInterest;
  final Set<PersonalityType> personalities;
  final Set<OccasionType> occasions;
  final String? customOccasion;
  final String? memo;

  const GiftRecommendationRequest({
    required this.recipient,
    this.ageGroup,
    this.gender,
    required this.minBudget,
    required this.maxBudget,
    required this.selectedMainCategories,
    required this.selectedSubCategories,
    this.customInterest,
    required this.personalities,
    required this.occasions,
    this.customOccasion,
    this.memo,
  });

  List<String> get allInterests {
    final result = <String>[...selectedMainCategories];
    for (final subs in selectedSubCategories.values) {
      result.addAll(subs);
    }
    if (customInterest != null && customInterest!.isNotEmpty) {
      result.add(customInterest!);
    }
    return result;
  }
}
