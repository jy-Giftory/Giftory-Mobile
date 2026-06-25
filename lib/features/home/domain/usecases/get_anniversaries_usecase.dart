import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/repositories/anniversary_repository.dart';

class GetAnniversariesUsecase {
  final AnniversaryRepository _repository;
  const GetAnniversariesUsecase(this._repository);

  Future<List<Anniversary>> call() => _repository.getAll();
}
