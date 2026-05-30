import 'package:flutter/material.dart';
import 'package:giftory/constants/color.dart';

class GiftoryTextStyle {
  /// small
  static TextStyle small1 = defaultTextStyle.copyWith(
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  static TextStyle small2 = defaultTextStyle.copyWith(
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static TextStyle small3 = defaultTextStyle.copyWith(
    fontSize: 8,
    fontWeight: FontWeight.w400,
  );

  static TextStyle small4 = defaultTextStyle.copyWith(
    fontSize: 6,
    fontWeight: FontWeight.w400,
  );

  /// header
   static TextStyle header1 = defaultTextStyle.copyWith(
     fontSize: 20,
     fontWeight: FontWeight.w700,
   );

   static TextStyle header2 = defaultTextStyle.copyWith(
     fontSize: 16,
     fontWeight: FontWeight.w700,
   );

   static TextStyle header3 = defaultTextStyle.copyWith(
     fontSize: 12,
     fontWeight: FontWeight.w700,
   );

   /// body
  static TextStyle body1 = defaultTextStyle.copyWith(
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static TextStyle body2 = defaultTextStyle.copyWith(
    fontSize: 16,
    fontWeight: FontWeight.w400
  );
}

const TextStyle defaultTextStyle = TextStyle(
  color: GiftoryColor.moca950,
  fontFamily: 'LINESeedSans',
);