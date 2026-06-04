import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';
import 'package:giftory/core/components/text_form_field/text_form_field.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/age_group.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gender_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/interest_category.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/occasion_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/personality_type.dart';
import 'package:giftory/features/gift_recommendation/presentation/providers/gift_recommendation_provider.dart';
import 'package:giftory/features/gift_recommendation/presentation/widgets/interest_category_section.dart';
import 'package:giftory/core/theme/app_theme.dart';

class GiftRecommendationInputScreen extends ConsumerStatefulWidget {
  const GiftRecommendationInputScreen({super.key});

  @override
  ConsumerState<GiftRecommendationInputScreen> createState() =>
      _GiftRecommendationInputScreenState();
}

class _GiftRecommendationInputScreenState
    extends ConsumerState<GiftRecommendationInputScreen> {
  final _recipientController = TextEditingController();
  final _minBudgetController = TextEditingController();
  final _maxBudgetController = TextEditingController();
  final _memoController = TextEditingController();
  final _customOccasionController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _minBudgetController.dispose();
    _maxBudgetController.dispose();
    _memoController.dispose();
    _customOccasionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(giftRecommendationFormProvider);
    final result = ref.watch(giftRecommendationResultProvider);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('AI 선물 추천', style: GiftoryTextStyle.header1),
                    SizedBox(height: 4),
                    Text(
                      '받는 사람의 정보를 입력하면 AI가 맞춤형 선물을 추천해드려요!\nAI의 추천은 완벽하지 않을 수 있으며, 실수를 할 수 있습니다.',
                      style: GiftoryTextStyle.small1
                          .copyWith(color: GiftoryColor.gray500),
                    ),
                    SizedBox(height: 24),
                    CustomTextFormField(
                      controller: _recipientController,
                      decoration: InputDecoration(
                        labelText: '받는사람',
                        hintText: '엄마, 친구…',
                        enabledBorder: _border(),
                        border: _border(),
                      ),
                      onChanged: (v) => ref
                          .read(giftRecommendationFormProvider.notifier)
                          .updateRecipient(v),
                    ),
                    SizedBox(height: 20),
                    _buildLabel('연령대'),
                    SizedBox(height: 8),
                    _buildChipRow<AgeGroup>(
                      items: AgeGroup.values,
                      label: (e) => e.label,
                      isSelected: (e) => form.ageGroup == e,
                      onTap: (e) => ref
                          .read(giftRecommendationFormProvider.notifier)
                          .selectAgeGroup(e),
                    ),
                    SizedBox(height: 20),
                    _buildLabel('성별'),
                    SizedBox(height: 8),
                    _buildChipRow<GenderType>(
                      items: GenderType.values,
                      label: (e) => e.label,
                      isSelected: (e) => form.gender == e,
                      onTap: (e) => ref
                          .read(giftRecommendationFormProvider.notifier)
                          .selectGender(e),
                    ),
                    SizedBox(height: 20),
                    _buildLabel('예산'),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: _buildBudgetField(
                            controller: _minBudgetController,
                            hint: '5,000',
                            onChanged: (v) {
                              final n = int.tryParse(v.replaceAll(',', ''));
                              if (n != null) {
                                ref
                                    .read(giftRecommendationFormProvider.notifier)
                                    .updateMinBudget(n);
                              }
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text('~',
                              style: GiftoryTextStyle.body2
                                  .copyWith(color: GiftoryColor.gray500)),
                        ),
                        Expanded(
                          child: _buildBudgetField(
                            controller: _maxBudgetController,
                            hint: '30,000',
                            onChanged: (v) {
                              final n = int.tryParse(v.replaceAll(',', ''));
                              if (n != null) {
                                ref
                                    .read(giftRecommendationFormProvider.notifier)
                                    .updateMaxBudget(n);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    _buildLabel('관심사'),
                    Text(
                      '중복선택이 가능하며 대분류만 선택하는 것도 가능합니다.',
                      style: GiftoryTextStyle.small2
                          .copyWith(color: GiftoryColor.gray400),
                    ),
                    SizedBox(height: 8),
                    ...kInterestCategories.map((cat) {
                      final isMain =
                          form.selectedMainCategories.contains(cat.name);
                      final subs =
                          form.selectedSubCategories[cat.name] ?? {};
                      return InterestCategorySection(
                        category: cat,
                        isMainSelected: isMain,
                        selectedSubs: subs,
                        customInterest: form.customInterest,
                        onMainTap: () => ref
                            .read(giftRecommendationFormProvider.notifier)
                            .toggleMainCategory(cat.name),
                        onSubTap: (sub) => ref
                            .read(giftRecommendationFormProvider.notifier)
                            .toggleSubCategory(cat.name, sub),
                        onCustomChanged: cat.name == '기타'
                            ? (v) => ref
                                .read(giftRecommendationFormProvider.notifier)
                                .updateCustomInterest(v)
                            : null,
                      );
                    }),
                    SizedBox(height: 8),
                    _buildLabel('성향'),
                    SizedBox(height: 8),
                    _buildChipRow<PersonalityType>(
                      items: PersonalityType.values,
                      label: (e) => e.label,
                      isSelected: (e) => form.personalities.contains(e),
                      onTap: (e) => ref
                          .read(giftRecommendationFormProvider.notifier)
                          .togglePersonality(e),
                    ),
                    SizedBox(height: 20),
                    _buildLabel('기념일'),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: OccasionType.values.map((o) {
                        final selected = form.occasions.contains(o);
                        return GestureDetector(
                          onTap: () => ref
                              .read(giftRecommendationFormProvider.notifier)
                              .selectOccasion(o),
                          child: _chip(o.label, selected),
                        );
                      }).toList(),
                    ),
                    if (form.occasions.contains(OccasionType.custom)) ...[
                      SizedBox(height: 8),
                      TextField(
                        controller: _customOccasionController,
                        onChanged: (v) => ref
                            .read(giftRecommendationFormProvider.notifier)
                            .updateCustomOccasion(v),
                        style: GiftoryTextStyle.small1,
                        decoration: InputDecoration(
                          hintText: '기념일을 입력해주세요',
                          hintStyle: GiftoryTextStyle.small1
                              .copyWith(color: GiftoryColor.gray300),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: GiftoryColor.gray200),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: GiftoryColor.gray200),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: context.appColors.c500),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 20),
                    _buildLabel('추가 메모 (선택)'),
                    SizedBox(height: 8),
                    TextField(
                      controller: _memoController,
                      onChanged: (v) => ref
                          .read(giftRecommendationFormProvider.notifier)
                          .updateMemo(v),
                      maxLines: 4,
                      style: GiftoryTextStyle.small1,
                      decoration: InputDecoration(
                        hintText:
                            'AI가 알아두면 좋은 추가사항이나 편지 작성 톤을 적어주세요.',
                        hintStyle: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray300),
                        contentPadding: const EdgeInsets.all(12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: GiftoryColor.gray200),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: GiftoryColor.gray200),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: context.appColors.c500),
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  20, 12, 20, MediaQuery.of(context).padding.bottom + 16),
              child: GiftoryButton(
                label: 'AI로 추천받기',
                isLoading: result is AsyncLoading,
                onPressed: form.isValid
                    ? () async {
                        final router = GoRouter.of(context);
                        await ref
                            .read(giftRecommendationResultProvider.notifier)
                            .fetch(form.toRequest());
                        if (!mounted) return;
                        router.push('/gift-recommend/result');
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) =>
      Text(text, style: GiftoryTextStyle.body2.copyWith(fontWeight: FontWeight.w700));

  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: GiftoryColor.gray200),
      );

  Widget _buildBudgetField({
    required TextEditingController controller,
    required ValueChanged<String> onChanged,
    required String hint,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: GiftoryTextStyle.small1,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray300),
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: GiftoryColor.gray200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: GiftoryColor.gray200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: context.appColors.c500),
        ),
      ),
    );
  }

  Widget _buildChipRow<T>({
    required List<T> items,
    required String Function(T) label,
    required bool Function(T) isSelected,
    required void Function(T) onTap,
  }) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: items
          .map((e) => GestureDetector(
                onTap: () => onTap(e),
                child: _chip(label(e), isSelected(e)),
              ))
          .toList(),
    );
  }

  Widget _chip(String text, bool selected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: selected ? context.appColors.c700 : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: selected ? context.appColors.c700 : GiftoryColor.gray300,
        ),
      ),
      child: Text(
        text,
        style: GiftoryTextStyle.small1.copyWith(
          color: selected ? Colors.white : GiftoryColor.gray600,
        ),
      ),
    );
  }
}
