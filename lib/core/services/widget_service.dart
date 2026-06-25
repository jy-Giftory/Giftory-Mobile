import 'package:home_widget/home_widget.dart';
import 'package:giftory/features/home/domain/entities/anniversary.dart';

class WidgetService {
  WidgetService._();
  static final WidgetService instance = WidgetService._();

  static const _appGroupId = 'group.com.example.giftory.widget';
  static const _androidWidgetName = 'GiftoryWidgetProvider';
  static const _iosWidgetName = 'GiftoryWidget';

  Future<void> init() async {
    await HomeWidget.setAppGroupId(_appGroupId);
  }

  Future<void> updateUpcoming(List<Anniversary> anniversaries) async {
    if (anniversaries.isEmpty) {
      await HomeWidget.saveWidgetData<String>('title', '등록된 기념일이 없어요');
      await HomeWidget.saveWidgetData<String>('dday', '');
      await HomeWidget.saveWidgetData<String>('subtitle', '기념일을 추가해보세요');
      await _render();
      return;
    }

    final sorted = [...anniversaries]
      ..sort((a, b) => a.dDay.compareTo(b.dDay));
    final nearest = sorted.first;

    await HomeWidget.saveWidgetData<String>('title', nearest.title);
    await HomeWidget.saveWidgetData<String>('dday', nearest.dDayLabel);
    await HomeWidget.saveWidgetData<String>(
      'subtitle',
      _formatDate(nearest.nextOccurrence),
    );
    await _render();
  }

  Future<void> _render() async {
    await HomeWidget.updateWidget(
      androidName: _androidWidgetName,
      iOSName: _iosWidgetName,
    );
  }

  String _formatDate(DateTime date) =>
      '${date.year}.${date.month.toString().padLeft(2, '0')}.'
      '${date.day.toString().padLeft(2, '0')}';
}
