import 'package:edict/pages/p1/entity/wordctable.dart';
import 'package:get/get.dart';

import 'p1/entity/groupctable.dart';

class GlobalController extends GetxController {
  final _pageIndex = 0.obs;
  set pageIndex(value) => _pageIndex.value = value;
  int get pageIndex => _pageIndex.value;
  var pageCurrentIndex = 0.obs;

  var datas = <Data>[].obs;
  var datasWord = <DataWord>[].obs;
}
