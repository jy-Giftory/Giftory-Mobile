import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:giftory/constants/color.dart';
import 'package:giftory/constants/text_style.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';
import 'package:giftory/features/wishlist/presentation/providers/wishlist_provider.dart';
import 'package:giftory/core/theme/app_theme.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(wishlistNotifierProvider);

    return Scaffold(
      backgroundColor: GiftoryColor.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('위시리스트', style: GiftoryTextStyle.header1),
                  SizedBox(height: 4),
                  Text(
                    '총 ${items.length}개의 아이템',
                    style: GiftoryTextStyle.small1
                        .copyWith(color: GiftoryColor.gray500),
                  ),
                ],
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? Center(
                      child: Text(
                        '아직 위시리스트가 비어있습니다.',
                        style: GiftoryTextStyle.body2
                            .copyWith(color: GiftoryColor.gray400),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      itemCount: items.length,
                      separatorBuilder: (context, index) => SizedBox(height: 12),
                      itemBuilder: (_, index) => _WishlistItemCard(
                        item: items[index],
                        onRemove: () => ref
                            .read(wishlistNotifierProvider.notifier)
                            .remove(items[index].id),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WishlistItemCard extends StatelessWidget {
  final GiftRecommendation item;
  final VoidCallback onRemove;

  const _WishlistItemCard({required this.item, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: GiftoryColor.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: GiftoryColor.gray100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GiftoryTextStyle.header1
                          .copyWith(color: context.appColors.c700),
                    ),
                    SizedBox(height: 2),
                    Text(
                      item.formattedPrice,
                      style: GiftoryTextStyle.body2
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Icon(Icons.favorite, color: GiftoryColor.red, size: 22),
            ],
          ),
          SizedBox(height: 12),
          _buildSection('추천 이유', item.reason),
          SizedBox(height: 8),
          _buildSection('전달 팁', item.deliveryTip),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () => _launchUrl(item.naverShoppingUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: context.appColors.c700,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      '구매하기',
                      style: GiftoryTextStyle.small1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: onRemove,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.appColors.c50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: context.appColors.c200),
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: GiftoryColor.red,
                    size: 20,
                  ),
                ),
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
