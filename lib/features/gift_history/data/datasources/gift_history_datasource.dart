import 'package:dio/dio.dart';
import 'package:giftory/features/gift_history/data/models/gift_history_model.dart';

class GiftHistoryDatasource {
  final Dio _dio;
  const GiftHistoryDatasource(this._dio);

  Future<List<GiftHistoryModel>> getAll() async {
    final res = await _dio.get('/histories', queryParameters: {'limit': 100});
    final list = res.data['histories'] as List;
    return list.map(_fromJson).toList();
  }

  Future<void> add(GiftHistoryModel model) async {
    await _dio.post('/histories', data: _toJson(model));
  }

  Future<void> delete(String id) async {
    await _dio.delete('/histories/$id');
  }

  GiftHistoryModel _fromJson(dynamic json) {
    return GiftHistoryModel(
      id: json['id'].toString(),
      recipientName: json['recipient'] as String,
      giftName: json['giftName'] as String,
      date: DateTime.parse(json['date'] as String).toIso8601String(),
      price: json['price'] as int,
      satisfaction: json['rating'] as int,
      occasionLabel: json['occasion'] as String?,
      memo: json['memo'] as String?,
      purchaseLink: json['purchaseUrl'] as String?,
    );
  }

  Map<String, dynamic> _toJson(GiftHistoryModel model) {
    return {
      'recipient': model.recipientName,
      'date': model.date.split('T').first,
      'giftName': model.giftName,
      'price': model.price,
      'rating': model.satisfaction,
      'occasion': model.occasionLabel ?? '',
      'memo': model.memo ?? '',
      'purchaseUrl': model.purchaseLink ?? '',
    };
  }
}
