import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/text_form_field/text_form_field.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/entities/repeat_type.dart';
import 'package:giftory/features/home/presentation/providers/anniversary_provider.dart';
import 'package:giftory/core/components/buttons/giftory_button.dart';

class AddAnniversaryScreen extends ConsumerStatefulWidget {
  const AddAnniversaryScreen({super.key});

  @override
  ConsumerState<AddAnniversaryScreen> createState() =>
      _AddAnniversaryScreenState();
}

class _AddAnniversaryScreenState extends ConsumerState<AddAnniversaryScreen> {
  final _titleController = TextEditingController();
  RepeatType _selectedRepeatType = RepeatType.yearly;

  late int _selectedYear;
  late int _selectedMonth;
  late int _selectedDay;

  static const int _startYear = 2020;
  static const int _endYear = 2035;

  late final FixedExtentScrollController _yearController;
  late final FixedExtentScrollController _monthController;
  late final FixedExtentScrollController _dayController;

  @override
  void initState() {
    super.initState();
    final selected = ref.read(selectedDayProvider);
    _selectedYear = selected.year.clamp(_startYear, _endYear);
    _selectedMonth = selected.month;
    _selectedDay = selected.day;

    _yearController = FixedExtentScrollController(
      initialItem: _selectedYear - _startYear,
    );
    _monthController = FixedExtentScrollController(
      initialItem: _selectedMonth - 1,
    );
    _dayController = FixedExtentScrollController(
      initialItem: _selectedDay - 1,
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    super.dispose();
  }

  int get _daysInSelectedMonth =>
      DateTime(_selectedYear, _selectedMonth + 1, 0).day;

  void _onYearChanged(int year) {
    setState(() {
      _selectedYear = year;
      final maxDays = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
      if (_selectedDay > maxDays) {
        _selectedDay = maxDays;
        _dayController.jumpToItem(maxDays - 1);
      }
    });
  }

  void _onMonthChanged(int month) {
    setState(() {
      _selectedMonth = month;
      final maxDays = DateTime(_selectedYear, _selectedMonth + 1, 0).day;
      if (_selectedDay > maxDays) {
        _selectedDay = maxDays;
        _dayController.jumpToItem(maxDays - 1);
      }
    });
  }

  Future<void> _onAdd() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) return;

    final anniversary = Anniversary(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      originalDate: DateTime(_selectedYear, _selectedMonth, _selectedDay),
      repeatType: _selectedRepeatType,
    );

    await ref.read(anniversaryNotifierProvider.notifier).add(anniversary);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GiftoryColor.background,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildDragHandle(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildTitleField(),
                  const SizedBox(height: 20),
                  _buildRepeatTypeSection(),
                  const SizedBox(height: 20),
                  _buildDateSection(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Center(
        child: Container(
          width: 48,
          height: 4,
          decoration: BoxDecoration(
            color: GiftoryColor.gray300,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return CustomTextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: '기념일 제목',
        hintText: '엄마, 친구…',
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GiftoryColor.gray200),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: GiftoryColor.gray200),
        ),
      ),
    );
  }

  Widget _buildRepeatTypeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '반복 주기',
          style: GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray950),
        ),
        const SizedBox(height: 8),
        Row(
          children: RepeatType.values.map((type) {
            final selected = _selectedRepeatType == type;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedRepeatType = type),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: selected ? GiftoryColor.moca700 : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: selected
                          ? GiftoryColor.moca700
                          : GiftoryColor.gray300,
                    ),
                  ),
                  child: Text(
                    type.label,
                    style: GiftoryTextStyle.small1.copyWith(
                      color: selected ? Colors.white : GiftoryColor.gray600,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '날짜',
          style: GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray950),
        ),
        const SizedBox(height: 8),
        _buildDatePicker(),
      ],
    );
  }

  Widget _buildDatePicker() {
    final years =
        List.generate(_endYear - _startYear + 1, (i) => _startYear + i);
    final months = List.generate(12, (i) => i + 1);
    final days = List.generate(_daysInSelectedMonth, (i) => i + 1);

    return SizedBox(
      height: 200,
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
                color: GiftoryColor.moca700,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: _buildPickerColumn(
                  controller: _yearController,
                  items: years,
                  selected: _selectedYear,
                  unit: '년',
                  onChanged: _onYearChanged,
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildPickerColumn(
                  controller: _monthController,
                  items: months,
                  selected: _selectedMonth,
                  unit: '월',
                  onChanged: _onMonthChanged,
                ),
              ),
              Expanded(
                flex: 2,
                child: _buildPickerColumn(
                  controller: _dayController,
                  items: days,
                  selected: _selectedDay,
                  unit: '일',
                  onChanged: (v) => setState(() => _selectedDay = v),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required List<int> items,
    required int selected,
    required String unit,
    required ValueChanged<int> onChanged,
  }) {
    return CupertinoPicker(
      scrollController: controller,
      itemExtent: 36,
      onSelectedItemChanged: (i) => onChanged(items[i]),
      selectionOverlay: const SizedBox.shrink(),
      backgroundColor: Colors.transparent,
      children: items.map((item) {
        final isSelected = item == selected;
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$item',
                style: GiftoryTextStyle.body2.copyWith(
                  color: isSelected ? Colors.white : GiftoryColor.gray400,
                  fontWeight:
                      isSelected ? FontWeight.w700 : FontWeight.w400,
                ),
              ),
              Text(
                unit,
                style: GiftoryTextStyle.small1.copyWith(
                  color: isSelected ? Colors.white : GiftoryColor.gray400,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      color: GiftoryColor.background,
      padding: EdgeInsets.fromLTRB(
        20,
        12,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      child: GiftoryButton(
        label: '기념일 추가',
        onPressed: _onAdd,
      ),
    );
  }
}
