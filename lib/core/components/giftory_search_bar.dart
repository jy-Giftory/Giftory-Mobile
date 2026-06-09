import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';

class GiftorySearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String> onChanged;
  final TextEditingController controller;

  const GiftorySearchBar({
    super.key,
    required this.controller,
    required this.onChanged,
    this.hintText = '검색',
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: GiftoryTextStyle.small1,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle:
            GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray400),
        prefixIcon: Icon(Icons.search, size: 20, color: GiftoryColor.gray400),
        suffixIcon: controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  controller.clear();
                  onChanged('');
                },
                child:
                    Icon(Icons.close, size: 18, color: GiftoryColor.gray400),
              )
            : null,
        isDense: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: GiftoryColor.gray50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: context.appColors.c400),
        ),
      ),
    );
  }
}

class GiftoryFilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const GiftoryFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? context.appColors.c700 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: selected ? context.appColors.c700 : GiftoryColor.gray300,
          ),
        ),
        child: Text(
          label,
          style: GiftoryTextStyle.small1.copyWith(
            color: selected ? Colors.white : GiftoryColor.gray600,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
