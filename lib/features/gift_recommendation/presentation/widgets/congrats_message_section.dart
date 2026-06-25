import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/components/giftory_snack_bar.dart';
import 'package:giftory/core/theme/app_theme.dart';

class CongratsMessageSection extends StatefulWidget {
  final String message;
  final ValueChanged<String> onSaved;

  const CongratsMessageSection({
    super.key,
    required this.message,
    required this.onSaved,
  });

  @override
  State<CongratsMessageSection> createState() => _CongratsMessageSectionState();
}

class _CongratsMessageSectionState extends State<CongratsMessageSection> {
  bool _isEditing = false;
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.message);
  }

  @override
  void didUpdateWidget(CongratsMessageSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing && oldWidget.message != widget.message) {
      _controller.text = widget.message;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startEditing() {
    setState(() => _isEditing = true);
  }

  void _save() {
    widget.onSaved(_controller.text);
    setState(() => _isEditing = false);
  }

  void _cancel() {
    _controller.text = widget.message;
    setState(() => _isEditing = false);
  }

  Future<void> _copy() async {
    if (widget.message.trim().isEmpty) return;
    await Clipboard.setData(ClipboardData(text: widget.message));
    if (mounted) {
      GiftorySnackBar.show(context, '메시지가 복사됐어요. 원하는 곳에 붙여넣어 보세요!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('축하 메시지 초안',
                style: GiftoryTextStyle.body2
                    .copyWith(fontWeight: FontWeight.w700)),
            if (!_isEditing)
              GestureDetector(
                onTap: _copy,
                child: Row(
                  children: [
                    Icon(Icons.copy_rounded,
                        size: 16, color: context.appColors.c600),
                    const SizedBox(width: 4),
                    Text('복사하기',
                        style: GiftoryTextStyle.small1
                            .copyWith(color: context.appColors.c600)),
                  ],
                ),
              ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '선물과 함께 전달할 메시지 초안 추천입니다.\n초안을 눌러 직접 수정하고 복사해보세요.',
          style: GiftoryTextStyle.small1.copyWith(color: GiftoryColor.gray500),
        ),
        const SizedBox(height: 12),
        _isEditing ? _buildEditMode(context) : _buildViewMode(context),
      ],
    );
  }

  Widget _buildViewMode(BuildContext context) {
    return GestureDetector(
      onTap: _startEditing,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.appColors.c50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.appColors.c100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.message, style: GiftoryTextStyle.small1),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.edit_outlined,
                    size: 12, color: GiftoryColor.gray400),
                const SizedBox(width: 4),
                Text(
                  '눌러서 직접 수정해보세요',
                  style: GiftoryTextStyle.small2
                      .copyWith(color: GiftoryColor.gray400),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditMode(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: GiftoryColor.background,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: context.appColors.c500),
          ),
          child: TextField(
            controller: _controller,
            autofocus: true,
            maxLines: null,
            minLines: 4,
            style: GiftoryTextStyle.small1,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.all(8),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: _cancel,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: GiftoryColor.gray300),
                ),
                child: Text('취소',
                    style: GiftoryTextStyle.small1
                        .copyWith(color: GiftoryColor.gray600)),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _save,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: context.appColors.c700,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text('저장',
                    style: GiftoryTextStyle.small1
                        .copyWith(color: Colors.white)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
