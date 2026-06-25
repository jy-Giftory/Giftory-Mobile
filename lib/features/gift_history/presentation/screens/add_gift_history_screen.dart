import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';
import 'package:giftory/core/components/giftory_snack_bar.dart';
import 'package:giftory/core/components/text_form_field/text_form_field.dart';
import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/presentation/providers/gift_history_provider.dart';
import 'package:giftory/features/gift_history/presentation/widgets/star_rating_widget.dart';
import 'package:giftory/features/wishlist/presentation/providers/wishlist_provider.dart';
import 'package:giftory/core/theme/app_theme.dart';

class AddGiftHistoryScreen extends ConsumerStatefulWidget {
  final String? prefillGiftName;
  final int? prefillPrice;
  final String? prefillMemo;
  final String? prefillLink;
  final String? fromWishlistId;
  const AddGiftHistoryScreen({
    super.key,
    this.prefillGiftName,
    this.prefillPrice,
    this.prefillMemo,
    this.prefillLink,
    this.fromWishlistId,
  });

  @override
  ConsumerState<AddGiftHistoryScreen> createState() =>
      _AddGiftHistoryScreenState();
}

class _AddGiftHistoryScreenState extends ConsumerState<AddGiftHistoryScreen> {
  final _recipientController = TextEditingController();
  final _giftController = TextEditingController();
  final _priceController = TextEditingController();
  final _memoController = TextEditingController();
  final _linkController = TextEditingController();
  final _customOccasionController = TextEditingController();

  int _satisfaction = 3;
  String? _selectedOccasion;
  bool _isSaving = false;

  final _now = DateTime.now();
  late int _year;
  late int _month;
  late int _day;
  static const int _startYear = 2020;
  static const int _endYear = 2035;

  late final FixedExtentScrollController _yearCtrl;
  late final FixedExtentScrollController _monthCtrl;
  late final FixedExtentScrollController _dayCtrl;

  static const _occasions = ['100일', '1주년', '생일', '어버이날', '직접입력'];

  @override
  void initState() {
    super.initState();
    _year = _now.year.clamp(_startYear, _endYear);
    _month = _now.month;
    _day = _now.day;
    _yearCtrl = FixedExtentScrollController(initialItem: _year - _startYear);
    _monthCtrl = FixedExtentScrollController(initialItem: _month - 1);
    _dayCtrl = FixedExtentScrollController(initialItem: _day - 1);
    if (widget.prefillGiftName != null) {
      _giftController.text = widget.prefillGiftName!;
    }
    if (widget.prefillPrice != null) {
      _priceController.text = widget.prefillPrice.toString();
    }
    if (widget.prefillMemo != null) {
      _memoController.text = widget.prefillMemo!;
    }
    if (widget.prefillLink != null) {
      _linkController.text = widget.prefillLink!;
    }
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _giftController.dispose();
    _priceController.dispose();
    _memoController.dispose();
    _linkController.dispose();
    _customOccasionController.dispose();
    _yearCtrl.dispose();
    _monthCtrl.dispose();
    _dayCtrl.dispose();
    super.dispose();
  }

  int get _daysInMonth => DateTime(_year, _month + 1, 0).day;

  void _onYearChanged(int v) {
    setState(() {
      _year = v;
      if (_day > _daysInMonth) {
        _day = _daysInMonth;
        _dayCtrl.jumpToItem(_day - 1);
      }
    });
  }

  void _onMonthChanged(int v) {
    setState(() {
      _month = v;
      if (_day > _daysInMonth) {
        _day = _daysInMonth;
        _dayCtrl.jumpToItem(_day - 1);
      }
    });
  }

  Future<void> _onSave() async {
    if (_isSaving) return;

    if (_recipientController.text.trim().isEmpty ||
        _giftController.text.trim().isEmpty) {
      return;
    }

    final cleanedPrice = _priceController.text.replaceAll(',', '').replaceAll(' ', '').trim();
    if (cleanedPrice.isEmpty) {
      GiftorySnackBar.show(context, '가격을 입력해주세요');
      return;
    }

    final price = int.tryParse(cleanedPrice);
    if (price == null) {
      GiftorySnackBar.show(context, '올바른 가격을 입력해주세요');
      return;
    }

    final occasionLabel = _selectedOccasion == '직접입력'
        ? (_customOccasionController.text.trim().isEmpty
            ? null
            : _customOccasionController.text.trim())
        : _selectedOccasion;

    final history = GiftHistory(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      recipientName: _recipientController.text.trim(),
      giftName: _giftController.text.trim(),
      date: DateTime(_year, _month, _day),
      price: price,
      satisfaction: _satisfaction,
      occasionLabel: occasionLabel,
      memo: _memoController.text.trim().isEmpty
          ? null
          : _memoController.text.trim(),
      purchaseLink: _linkController.text.trim().isEmpty
          ? null
          : _linkController.text.trim(),
    );

    setState(() => _isSaving = true);
    try {
      await ref.read(giftHistoryNotifierProvider.notifier).add(history);
      if (widget.fromWishlistId != null) {
        await ref
            .read(wishlistNotifierProvider.notifier)
            .removeByServerId(widget.fromWishlistId!);
      }
      if (!mounted) return;
      context.pop();
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Icon(Icons.chevron_left,
                        size: 24, color: context.appColors.c950),
                  ),
                  SizedBox(width: 4),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('히스토리', style: GiftoryTextStyle.header2),
                      Text(
                        '주었던 선물과 반응을 기록하세요.',
                        style: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray500),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      controller: _recipientController,
                      decoration: InputDecoration(
                        labelText: '받는사람',
                        hintText: '엄마, 친구…',
                        enabledBorder: _border(),
                        border: _border(),
                      ),
                    ),
                    SizedBox(height: 16),
                    CustomTextFormField(
                      controller: _giftController,
                      decoration: InputDecoration(
                        labelText: '선물',
                        hintText: '축구공, 가방…',
                        enabledBorder: _border(),
                        border: _border(),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildLabel('기념일'),
                    SizedBox(height: 8),
                    _buildDatePicker(),
                    SizedBox(height: 16),
                    _buildLabel('가격'),
                    SizedBox(height: 8),
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: GiftoryTextStyle.small1,
                      decoration: InputDecoration(
                        hintText: '100,000',
                        hintStyle: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray300),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        border: _border(),
                        enabledBorder: _border(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: context.appColors.c500),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildLabel('만족도'),
                    SizedBox(height: 8),
                    StarRatingWidget(
                      rating: _satisfaction,
                      size: 32,
                      onChanged: (v) => setState(() => _satisfaction = v),
                    ),
                    SizedBox(height: 16),
                    _buildLabel('기념일'),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: _occasions.map((o) {
                        final selected = _selectedOccasion == o;
                        return GestureDetector(
                          onTap: () => setState(() {
                            _selectedOccasion = selected ? null : o;
                          }),
                          child: _chip(o, selected),
                        );
                      }).toList(),
                    ),
                    if (_selectedOccasion == '직접입력') ...[
                      SizedBox(height: 8),
                      TextField(
                        controller: _customOccasionController,
                        style: GiftoryTextStyle.small1,
                        decoration: InputDecoration(
                          hintText: '기념일을 입력해주세요',
                          hintStyle: GiftoryTextStyle.small1
                              .copyWith(color: GiftoryColor.gray300),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          border: _border(),
                          enabledBorder: _border(),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                                BorderSide(color: context.appColors.c500),
                          ),
                        ),
                      ),
                    ],
                    SizedBox(height: 16),
                    _buildLabel('메모 (선택)'),
                    SizedBox(height: 8),
                    TextField(
                      controller: _memoController,
                      maxLines: 4,
                      style: GiftoryTextStyle.small1,
                      decoration: InputDecoration(
                        hintText: '상대방의 반응이나, 기억해두면 좋은 것들, 추억을 적어주세요.',
                        hintStyle: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray300),
                        contentPadding: const EdgeInsets.all(14),
                        border: _border(),
                        enabledBorder: _border(),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: context.appColors.c500),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    _buildLabel('구매 링크'),
                    SizedBox(height: 8),
                    TextField(
                      controller: _linkController,
                      keyboardType: TextInputType.url,
                      style: GiftoryTextStyle.small1,
                      decoration: InputDecoration(
                        hintText: 'https://',
                        hintStyle: GiftoryTextStyle.small1
                            .copyWith(color: GiftoryColor.gray300),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 10),
                        border: _border(),
                        enabledBorder: _border(),
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
                label: '기록하기',
                onPressed: _isSaving ? null : _onSave,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) =>
      Text(text, style: GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray950));

  OutlineInputBorder _border() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: GiftoryColor.gray200),
      );

  Widget _chip(String text, bool selected) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? context.appColors.c700 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: selected ? context.appColors.c700 : GiftoryColor.gray300),
        ),
        child: Text(text,
            style: GiftoryTextStyle.small1.copyWith(
                color: selected ? Colors.white : GiftoryColor.gray600)),
      );

  Widget _buildDatePicker() {
    final years = List.generate(_endYear - _startYear + 1, (i) => _startYear + i);
    final months = List.generate(12, (i) => i + 1);
    final days = List.generate(_daysInMonth, (i) => i + 1);

    return SizedBox(
      height: 180,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 36,
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: context.appColors.c700,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(flex: 3, child: _picker(_yearCtrl, years, _year, '년', _onYearChanged)),
              Expanded(flex: 2, child: _picker(_monthCtrl, months, _month, '월', _onMonthChanged)),
              Expanded(flex: 2, child: _picker(_dayCtrl, days, _day, '일', (v) => setState(() => _day = v))),
            ],
          ),
        ],
      ),
    );
  }

  Widget _picker(FixedExtentScrollController ctrl, List<int> items, int selected,
      String unit, ValueChanged<int> onChanged) {
    return CupertinoPicker(
      scrollController: ctrl,
      itemExtent: 36,
      onSelectedItemChanged: (i) => onChanged(items[i]),
      selectionOverlay: const SizedBox.shrink(),
      backgroundColor: Colors.transparent,
      children: items.map((item) {
        final sel = item == selected;
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('$item',
                  style: GiftoryTextStyle.body2.copyWith(
                      color: sel ? Colors.white : GiftoryColor.gray400,
                      fontWeight: sel ? FontWeight.w700 : FontWeight.w400)),
              Text(unit,
                  style: GiftoryTextStyle.small1.copyWith(
                      color: sel ? Colors.white : GiftoryColor.gray400)),
            ],
          ),
        );
      }).toList(),
    );
  }
}
