import 'package:giftory/features/home/domain/entities/anniversary.dart';

abstract class AnniversaryRepository {
  Future<List<Anniversary>> getAll();
  Future<void> add(Anniversary anniversary);
  Future<void> delete(String id);
  Future<void> update(Anniversary anniversary);

}
