import 'package:get/get.dart';
import 'package:winly/models/notice/notice.dart';
import 'package:winly/services/api/notice.dart';

class NotificationController extends GetxController {
  final Rx<List<Notice>> _notifications = Rx<List<Notice>>([]);

  List<Notice> get notifications => _notifications.value;

  NotificationController() {
    fetchNotifications();
  }

  void addNotification(Notice notice) {
    _notifications.value.add(notice);
    update();
  }

  void fetchNotifications() async {
    List<Notice>? notices = await NoticeApi.getNotifications();
    if (notices != null) {
      _notifications.value = notices;
      update();
    }
  }

  void removeNotification(Notice notice) {
    _notifications.value.remove(notice);
    update();
  }

  void clearNotifications() {
    _notifications.value.clear();
    update();
  }

  @override
  void onClose() {
    _notifications.value.clear();
    super.onClose();
  }
}
