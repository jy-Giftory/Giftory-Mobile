import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';

class CustomTextFormFieldLabel extends StatelessWidget {
  const CustomTextFormFieldLabel({
    super.key,
    this.label,
    this.labelText,
    this.labelStyle,
  }) : assert(
         label != null || labelText != null,
         'Either label or labelText must be provided',
       );

  final Widget? label;
  final String? labelText;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = GiftoryTextStyle.small1.copyWith(
      color: GiftoryColor.gray950,
    );
    return DefaultTextStyle(
      style: defaultTextStyle.merge(labelStyle),
      child: Row(children: [label ?? Text(labelText!)]),
    );
  }
}
