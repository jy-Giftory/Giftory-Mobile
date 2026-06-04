import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/repositories/anniversary_repository.dart';

class UpdateAnniversaryUsecase {
  final AnniversaryRepository _repository;
  const UpdateAnniversaryUsecase(this._repository);
  Future<void> call(Anniversary anniversary) => _repository.update(anniversary);
}
