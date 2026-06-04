import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/features/home/data/datasources/anniversary_datasource.dart';
import 'package:giftory/features/home/data/repositories/anniversary_repository_impl.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/usecases/add_anniversary_usecase.dart';
import 'package:giftory/features/home/domain/usecases/delete_anniversary_usecase.dart';
import 'package:giftory/features/home/domain/usecases/get_anniversaries_usecase.dart';

part 'anniversary_provider.g.dart';

@riverpod
AnniversaryDatasource anniversaryDatasource(Ref ref) {
  return AnniversaryDatasource();
}

@riverpod
AnniversaryRepositoryImpl anniversaryRepository(Ref ref) {
  return AnniversaryRepositoryImpl(ref.watch(anniversaryDatasourceProvider));
}

@riverpod
class AnniversaryNotifier extends _$AnniversaryNotifier {
  @override
  Future<List<Anniversary>> build() async {
    final repo = ref.watch(anniversaryRepositoryProvider);
    return GetAnniversariesUsecase(repo).call();
  }

  Future<void> add(Anniversary anniversary) async {
    final repo = ref.read(anniversaryRepositoryProvider);
    await AddAnniversaryUsecase(repo).call(anniversary);
    ref.invalidateSelf();
  }

  Future<void> delete(String id) async {
    final repo = ref.read(anniversaryRepositoryProvider);
    await DeleteAnniversaryUsecase(repo).call(id);
    ref.invalidateSelf();
  }
}

@riverpod
class SelectedDay extends _$SelectedDay {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  void select(DateTime day) {
    state = DateTime(day.year, day.month, day.day);
  }
}

@riverpod
class FocusedMonth extends _$FocusedMonth {
  @override
  DateTime build() {
    final now = DateTime.now();
    return DateTime(now.year, now.month);
  }

  void previous() {
    state = DateTime(state.year, state.month - 1);
  }

  void next() {
    state = DateTime(state.year, state.month + 1);
  }
}
