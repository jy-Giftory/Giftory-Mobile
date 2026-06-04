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

  const GiftHistory({
    required this.id,
    required this.recipientName,
    required this.giftName,
    required this.date,
    required this.price,
    required this.satisfaction,
    this.occasionLabel,
    this.memo,
    this.purchaseLink,
  });

  String get formattedPrice => NumberFormat('#,###').format(price);
  String get formattedDate => DateFormat('yyyy.MM.dd').format(date);
}
