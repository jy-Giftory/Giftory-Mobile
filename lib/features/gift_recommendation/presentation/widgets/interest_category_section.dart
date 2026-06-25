import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/interest_category.dart';
import 'package:giftory/core/theme/app_theme.dart';

class InterestCategorySection extends StatelessWidget {
  final InterestCategory category;
  final bool isMainSelected;
  final Set<String> selectedSubs;
  final String customInterest;
  final VoidCallback onMainTap;
  final void Function(String sub) onSubTap;
  final void Function(String value)? onCustomChanged;

  const InterestCategorySection({
    super.key,
    required this.category,
    required this.isMainSelected,
    required this.selectedSubs,
    required this.customInterest,
    required this.onMainTap,
    required this.onSubTap,
    this.onCustomChanged,
  });

  bool get _isCustomCategory => category.name == '기타';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onMainTap,
            child: Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isMainSelected
                        ? context.appColors.c600
                        : Colors.transparent,
                    border: Border.all(
                      color: isMainSelected
                          ? context.appColors.c600
                          : GiftoryColor.gray300,
                      width: 1.5,
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  category.name,
                  style: GiftoryTextStyle.body2
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          if (isMainSelected) ...[
            SizedBox(height: 8),
            if (_isCustomCategory)
              _buildCustomInput(context)
            else if (category.subCategories.isNotEmpty)
              _buildSubChips(context),
          ],
        ],
      ),
    );
  }

  Widget _buildSubChips(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 6,
      children: category.subCategories.map((sub) {
        final isSelected = selectedSubs.contains(sub);
        return GestureDetector(
          onTap: () => onSubTap(sub),
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? context.appColors.c700 : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected
                    ? context.appColors.c700
                    : GiftoryColor.gray300,
              ),
            ),
            child: Text(
              sub,
              style: GiftoryTextStyle.small1.copyWith(
                color: isSelected ? Colors.white : GiftoryColor.gray600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomInput(BuildContext context) {
    return TextField(
      onChanged: onCustomChanged,
      style: GiftoryTextStyle.small1,
      decoration: InputDecoration(
        hintText: '관심사를 입력해주세요',
        hintStyle:
            GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray300),
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
}
