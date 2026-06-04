import 'package:giftory/features/gift_history/domain/entities/gift_history.dart';

abstract class GiftHistoryRepository {
  Future<List<GiftHistory>> getAll();
  Future<void> add(GiftHistory history);
  Future<void> delete(String id);
}
