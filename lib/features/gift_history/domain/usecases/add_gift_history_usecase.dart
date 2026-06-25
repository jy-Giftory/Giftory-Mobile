import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/domain/repositories/gift_history_repository.dart';

class AddGiftHistoryUsecase {
  final GiftHistoryRepository _repository;
  const AddGiftHistoryUsecase(this._repository);
  Future<void> call(GiftHistory history) => _repository.add(history);
}
