import 'package:intl/intl.dart';

class GiftRecommendation {
  final String id;
  final String title;
  final int price;
  final String reason;
  final String deliveryTip;
  final String searchQuery;
  bool isInWishlist;

  GiftRecommendation({
    required this.id,
    required this.title,
    required this.price,
    required this.reason,
    required this.deliveryTip,
    required this.searchQuery,
    this.isInWishlist = false,
  });

  String get formattedPrice => NumberFormat('#,###').format(price);

  String get naverShoppingUrl =>
      'https://search.shopping.naver.com/search/all?query=${Uri.encodeComponent(searchQuery)}';
}
