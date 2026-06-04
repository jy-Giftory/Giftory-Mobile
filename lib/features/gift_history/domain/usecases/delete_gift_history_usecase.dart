import 'package:giftory/features/gift_history/domain/repositories/gift_history_repository.dart';

class DeleteGiftHistoryUsecase {
  final GiftHistoryRepository _repository;
  const DeleteGiftHistoryUsecase(this._repository);
  Future<void> call(String id) => _repository.delete(id);
}
