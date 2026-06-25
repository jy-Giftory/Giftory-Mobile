import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/repositories/anniversary_repository.dart';

class AddAnniversaryUsecase {
  final AnniversaryRepository _repository;
  const AddAnniversaryUsecase(this._repository);

  Future<void> call(Anniversary anniversary) => _repository.add(anniversary);
}
