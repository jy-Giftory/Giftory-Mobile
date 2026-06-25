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

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'price': price,
        'reason': reason,
        'deliveryTip': deliveryTip,
        'searchQuery': searchQuery,
        'isInWishlist': isInWishlist,
      };

  factory GiftRecommendation.fromJson(Map<String, dynamic> json) =>
      GiftRecommendation(
        id: json['id'] as String,
        title: json['title'] as String,
        price: json['price'] as int,
        reason: json['reason'] as String,
        deliveryTip: json['deliveryTip'] as String,
        searchQuery: json['searchQuery'] as String,
        isInWishlist: json['isInWishlist'] as bool? ?? false,
      );
}
