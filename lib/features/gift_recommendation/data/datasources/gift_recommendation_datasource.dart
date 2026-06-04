import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:giftory/core/config/api_config.dart';
import 'package:giftory/features/gift_recommendation/data/models/gift_recommendation_model.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/age_group.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gender_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/gift_recommendation_request.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/occasion_type.dart';
import 'package:giftory/features/gift_recommendation/domain/entities/personality_type.dart';

class GiftRecommendationDatasource {
  final Dio _dio = Dio();

  Future<GiftRecommendationResponseModel> fetch(
      GiftRecommendationRequest request) async {
    final prompt = _buildPrompt(request);

    final response = await _dio.post(
      '${ApiConfig.anthropicBaseUrl}/messages',
      options: Options(headers: {
        'x-api-key': ApiConfig.anthropicApiKey,
        'anthropic-version': ApiConfig.anthropicVersion,
        'content-type': 'application/json',
      }),
      data: {
        'model': ApiConfig.claudeModel,
        'max_tokens': 2048,
        'messages': [
          {'role': 'user', 'content': prompt},
        ],
      },
    );

    final text =
        response.data['content'][0]['text'] as String;
    final jsonStr = _extractJson(text);
    final json = jsonDecode(jsonStr) as Map<String, dynamic>;
    return GiftRecommendationResponseModel.fromJson(json);
  }

  String _buildPrompt(GiftRecommendationRequest req) {
    final interests = req.allInterests.join(', ');
    final personalities =
        req.personalities.map((p) => p.label).join(', ');
    final occasions = [
      ...req.occasions.where((o) => o != OccasionType.custom).map((o) => o._label),
      if (req.customOccasion != null && req.customOccasion!.isNotEmpty)
        req.customOccasion!,
    ].join(', ');

    return '''
당신은 선물 추천 전문가입니다. 아래 정보를 바탕으로 최적의 선물 3~5개를 추천하고 축하 메시지 초안을 작성해주세요.

[받는 사람 정보]
- 이름/관계: ${req.recipient}
- 연령대: ${req.ageGroup?.label ?? '미입력'}
- 성별: ${req.gender?.label ?? '미입력'}
- 예산: ${req.minBudget}원 ~ ${req.maxBudget}원
- 관심사: $interests
- 성향: ${personalities.isEmpty ? '미입력' : personalities}
- 기념일: ${occasions.isEmpty ? '미입력' : occasions}
- 추가 메모: ${req.memo?.isEmpty ?? true ? '없음' : req.memo}

반드시 아래 JSON 형식으로만 응답해주세요. 다른 텍스트는 포함하지 마세요:
{
  "subtitle": "${req.recipient}을(를) 위한 추천 선물",
  "recommendations": [
    {
      "title": "상품명",
      "price": 숫자,
      "reason": "추천 이유 (2~3문장)",
      "delivery_tip": "전달 팁 (1~2문장)",
      "search_query": "네이버 쇼핑 검색어"
    }
  ],
  "congrats_message": "To. ${req.recipient}에게\\n\\n축하 메시지 내용"
}
''';
  }

  String _extractJson(String text) {
    final match =
        RegExp(r'```(?:json)?\s*([\s\S]*?)```').firstMatch(text);
    if (match != null) return match.group(1)!.trim();
    final start = text.indexOf('{');
    final end = text.lastIndexOf('}');
    if (start != -1 && end != -1) return text.substring(start, end + 1);
    return text.trim();
  }
}

extension _OccasionTypeLabel on OccasionType {
  String get _label {
    switch (this) {
      case OccasionType.hundredDays: return '100일';
      case OccasionType.oneYear:     return '1주년';
      case OccasionType.birthday:    return '생일';
      case OccasionType.parentsDay:  return '어버이날';
      case OccasionType.custom:      return '';
    }
  }
}
