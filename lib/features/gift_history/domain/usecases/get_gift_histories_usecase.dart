import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';
import 'package:giftory/features/gift_history/domain/repositories/gift_history_repository.dart';

class GetGiftHistoriesUsecase {
  final GiftHistoryRepository _repository;
  const GetGiftHistoriesUsecase(this._repository);
  Future<List<GiftHistory>> call() => _repository.getAll();
}
