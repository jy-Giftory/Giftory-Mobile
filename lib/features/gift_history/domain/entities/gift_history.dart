import 'package:intl/intl.dart';

class GiftHistory {
  final String id;
  final String recipientName;
  final String giftName;
  final DateTime date;
  final int price;
  final int satisfaction;
  final String? occasionLabel;
  final String? memo;
  final String? purchaseLink;

  GiftHistory({
    required this.id,
    required this.recipientName,
    required this.giftName,
    required this.date,
    required this.price,
    required this.satisfaction,
    this.occasionLabel,
    this.memo,
    this.purchaseLink,
  }) {
    if (id.isEmpty) {
      throw ArgumentError('id must not be empty');
    }
    if (recipientName.isEmpty) {
      throw ArgumentError('recipientName must not be empty');
    }
    if (giftName.isEmpty) {
      throw ArgumentError('giftName must not be empty');
    }
    if (price < 0) {
      throw ArgumentError('price must be >= 0');
    }
    if (satisfaction < 0 || satisfaction > 5) {
      throw ArgumentError('satisfaction must be within 0..5');
    }
  }

  String get formattedPrice => NumberFormat('#,###').format(price);
  String get formattedDate => DateFormat('yyyy.MM.dd').format(date);
}
