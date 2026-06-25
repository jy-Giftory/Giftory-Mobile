import 'package:intl/intl.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation.dart';

class RecommendationRecord {
  final String id;
  final DateTime createdAt;
  final String recipient;
  final String subtitle;
  final List<GiftRecommendation> items;
  final String congratsMessage;

  RecommendationRecord({
    required this.id,
    required this.createdAt,
    required this.recipient,
    required this.subtitle,
    required this.items,
    required this.congratsMessage,
  });

  String get formattedDate => DateFormat('yyyy.MM.dd HH:mm').format(createdAt);

  String get summary {
    if (items.isEmpty) return '추천 결과 없음';
    final names = items.map((e) => e.title).take(3).join(', ');
    return items.length > 3 ? '$names 외 ${items.length - 3}건' : names;
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'recipient': recipient,
        'subtitle': subtitle,
        'items': items.map((e) => e.toJson()).toList(),
        'congratsMessage': congratsMessage,
      };

  factory RecommendationRecord.fromJson(Map<String, dynamic> json) =>
      RecommendationRecord(
        id: json['id'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        recipient: json['recipient'] as String? ?? '',
        subtitle: json['subtitle'] as String? ?? '',
        items: (json['items'] as List)
            .map((e) =>
                GiftRecommendation.fromJson(e as Map<String, dynamic>))
            .toList(),
        congratsMessage: json['congratsMessage'] as String? ?? '',
      );
}
