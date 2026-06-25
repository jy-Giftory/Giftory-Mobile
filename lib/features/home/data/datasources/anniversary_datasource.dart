import 'package:dio/dio.dart';
import 'package:giftory/features/home/data/models/anniversary_model.dart';

class AnniversaryDatasource {
  final Dio _dio;
  const AnniversaryDatasource(this._dio);

  static const _toCycle = {
    'yearly': 'YEARLY',
    'monthly': 'MONTHLY',
    'biMonthly': 'BIOMONTHLY',
  };
  static const _fromCycle = {
    'YEARLY': 'yearly',
    'MONTHLY': 'monthly',
    'BIOMONTHLY': 'biMonthly',
  };

  Future<List<AnniversaryModel>> getAll() async {
    final res = await _dio.get('/anniverseries');
    final list = res.data as List;
    return list.map(_fromJson).toList();
  }

  Future<void> add(AnniversaryModel model) async {
    await _dio.post('/anniverseries', data: _toJson(model));
  }

  Future<void> delete(String id) async {
    await _dio.delete('/anniverseries/$id');
  }

  Future<void> update(AnniversaryModel model) async {
    await _dio.put('/anniverseries/${model.id}', data: _toJson(model));
  }

  AnniversaryModel _fromJson(dynamic json) {
    final date = json['date'] as String; // YYYY-MM-DD
    return AnniversaryModel(
      id: json['id'].toString(),
      title: json['title'] as String,
      originalDate: DateTime.parse(date).toIso8601String(),
      repeatType: _fromCycle[json['repeatCycle']] ?? 'yearly',
    );
  }

  Map<String, dynamic> _toJson(AnniversaryModel model) {
    final dateOnly = model.originalDate.split('T').first;
    return {
      'title': model.title,
      'date': dateOnly,
      'repeatCycle': _toCycle[model.repeatType] ?? 'YEARLY',
    };
  }
}
