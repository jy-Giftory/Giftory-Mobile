import 'package:giftory/features/home/data/datasources/anniversary_datasource.dart';
import 'package:giftory/features/home/data/models/anniversary_model.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/repositories/anniversary_repository.dart';

class AnniversaryRepositoryImpl implements AnniversaryRepository {
  final AnniversaryDatasource _datasource;
  const AnniversaryRepositoryImpl(this._datasource);

  @override
  Future<List<Anniversary>> getAll() async {
    final models = await _datasource.getAll();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> add(Anniversary anniversary) async {
    await _datasource.add(anniversary.toModel());
  }

  @override
  Future<void> delete(String id) async {
    await _datasource.delete(id);
  }

  @override
  Future<void> update(Anniversary anniversary) async {
    await _datasource.update(anniversary.toModel());
  }
}
