import 'package:giftory/features/home/domain/repositories/anniversary_repository.dart';

class DeleteAnniversaryUsecase {
  final AnniversaryRepository _repository;
  const DeleteAnniversaryUsecase(this._repository);

  Future<void> call(String id) => _repository.delete(id);
}
