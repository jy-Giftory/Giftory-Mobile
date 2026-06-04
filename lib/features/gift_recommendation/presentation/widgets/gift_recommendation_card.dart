import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/core/theme/app_theme.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';

class GiftRecommendationCard extends StatelessWidget {
  final GiftRecommendation item;
  final bool isInWishlist;
  final VoidCallback onWishlistToggle;

  const GiftRecommendationCard({
    super.key,
    required this.item,
    required this.isInWishlist,
    required this.onWishlistToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GiftoryColor.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GiftoryColor.gray100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(item.title,
              style: GiftoryTextStyle.header1
                  .copyWith(color: context.appColors.c950)),
          SizedBox(height: 4),
          Text(item.formattedPrice,
              style: GiftoryTextStyle.body2
                  .copyWith(fontWeight: FontWeight.w700)),
          SizedBox(height: 12),
          _buildSection('추천 이유', item.reason),
          SizedBox(height: 8),
          _buildSection('전달 팁', item.deliveryTip),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => _launchUrl(item.naverShoppingUrl),
                child: Text(
                  '최저가 링크 보러 가기',
                  style: GiftoryTextStyle.small1.copyWith(
                    color: GiftoryColor.gray500,
                    decoration: TextDecoration.underline,
                    decorationColor: GiftoryColor.gray500,
                  ),
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => context.push(
                      '/gift-history/add',
                      extra: {'giftName': item.title, 'price': item.price},
                    ),
                    child: Text(
                      '기록하기',
                      style: GiftoryTextStyle.small1.copyWith(
                        color: context.appColors.c600,
                        decoration: TextDecoration.underline,
                        decorationColor: context.appColors.c600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: onWishlistToggle,
                    child: Icon(
                      isInWishlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWishlist
                          ? GiftoryColor.red
                          : GiftoryColor.gray400,
                      size: 22,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: GiftoryTextStyle.small1
                .copyWith(fontWeight: FontWeight.w700)),
        SizedBox(height: 4),
        Text(content, style: GiftoryTextStyle.small1),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }
}
