import 'package:edict/pages/p1/entity/wordctable.dart';
import 'package:get/get.dart';

import 'p1/entity/groupctable.dart';

class GlobalController extends GetxController {
  ///数据加载起始id=1
  int startId = 0;
  final int max = 10;

  ///隐藏加载指示标志
  final ishide = true.obs;

  ///
  final _pageIndex = 0.obs;
  set pageIndex(value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
  var pageCurrentIndex = 0.obs;

  var datasG = <DataG>[].obs;
  var datasWord = <DataWord>[].obs;
}
