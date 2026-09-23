part of 'index.dart';

class HomeController extends GetxController {
  final RefreshController refreshController = RefreshController(
    initialRefresh: true,
  );

  List<int> list = [];

  bool _finish = false;

  Future<void> _getList([bool isRefresh = false]) async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (isRefresh) list.clear();
    for (var index = 0; index < 10; index++) {
      list.add(index);
    }
    _finish = list.length >= 40;
    update();
  }

  void onRefresh() async {
    try {
      await _getList(true);
      refreshController.refreshCompleted(resetFooterState: true);
    } catch (error) {
      refreshController.refreshFailed();
    }
  }

  void onLoading() async {
    if (_finish) {
      refreshController.loadNoData();
      return;
    }
    try {
      await _getList();
      refreshController.loadComplete();
    } catch (error) {
      refreshController.loadFailed();
    }
  }
}
