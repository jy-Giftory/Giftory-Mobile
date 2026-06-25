import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:giftory/core/network/dio_client.dart';
import 'package:giftory/core/services/notification_service.dart';
import 'package:giftory/core/services/widget_service.dart';
import 'package:giftory/features/home/data/datasources/anniversary_datasource.dart';
import 'package:giftory/features/home/data/repositories/anniversary_repository_impl.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';
import 'package:giftory/features/home/domain/usecases/add_anniversary_usecase.dart';
import 'package:giftory/features/home/domain/usecases/delete_anniversary_usecase.dart';
import 'package:giftory/features/home/domain/usecases/get_anniversaries_usecase.dart';
import 'package:giftory/features/home/domain/usecases/update_anniversary_usecase.dart';
import 'package:giftory/features/settings/presentation/providers/settings_provider.dart';

part 'anniversary_provider.g.dart';

@riverpod
AnniversaryDatasource anniversaryDatasource(Ref ref) =>
    AnniversaryDatasource(ref.watch(dioProvider));

@riverpod
AnniversaryRepositoryImpl anniversaryRepository(Ref ref) =>
    AnniversaryRepositoryImpl(ref.watch(anniversaryDatasourceProvider));

@riverpod
class AnniversaryNotifier extends _$AnniversaryNotifier {
  @override
  Future<List<Anniversary>> build() async {
    final repo = ref.watch(anniversaryRepositoryProvider);
    final list = await GetAnniversariesUsecase(repo).call();
    WidgetService.instance.updateUpcoming(list);
    return list;
  }

  Future<void> add(Anniversary anniversary) async {
    final repo = ref.read(anniversaryRepositoryProvider);
    await AddAnniversaryUsecase(repo).call(anniversary);
    final settings = ref.read(settingsNotifierProvider);
    await NotificationService.instance.scheduleForAnniversary(anniversary, settings);
    ref.invalidateSelf();
  }

  Future<void> updateAnniversary(Anniversary anniversary) async {
    final repo = ref.read(anniversaryRepositoryProvider);
    await UpdateAnniversaryUsecase(repo).call(anniversary);
    final settings = ref.read(settingsNotifierProvider);
    await NotificationService.instance.scheduleForAnniversary(anniversary, settings);
    ref.invalidateSelf();
  }

  Future<void> delete(String id) async {
    final current = state.valueOrNull ?? [];
    final updated = current.where((a) => a.id != id).toList();
    state = AsyncData(updated);
    final repo = ref.read(anniversaryRepositoryProvider);
    await DeleteAnniversaryUsecase(repo).call(id);
    await NotificationService.instance.cancelForAnniversary(id);
    await WidgetService.instance.updateUpcoming(updated);
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

  void previous() => state = DateTime(state.year, state.month - 1);
  void next() => state = DateTime(state.year, state.month + 1);
}
