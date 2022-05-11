import 'dart:convert' as convert;

import 'package:get/get.dart';

import '../../../shared/net_provider.dart';
import '../../global_controller.dart';
import '../entity/groupctable.dart';
import '../entity/wordctable.dart';

final controller = Get.find<GlobalController>();

class DataProvider {
  DataProvider._() {
    _h = this;
  }
  static DataProvider? _h;
  factory DataProvider() {
    return _h ??= DataProvider._();
  }

  _fetchItemData(page) async {
    var jsonData = {"table_id": "groupTableC", "dy": '$page'};
    String str = convert.jsonEncode(jsonData);
    var response = await NetProvider().dio!.get('/api_group?' + str);
    var vv = GroupCTable.fromJson(response.data);
    return vv.data;
  }

  Future<dynamic> onItemsRefresh() {
    controller.datas.clear();
    return _fetchItemData(1).then((dta) {
      controller.datas.addAll(dta);
    });
  }

  _fetchWordData(page) async {
    var jsonData = {"table_id": "cg1", "dy": '$page'};
    String str = convert.jsonEncode(jsonData);
    var response = await NetProvider().dio!.get('/api_word?' + str);
    var vv = WordCTable.fromJson(response.data);
    return vv.data;
  }

  Future<dynamic> onWordsRefresh2() {
    controller.datasWord.clear();
    return _fetchWordData(1).then((dta) {
      controller.datasWord.addAll(dta);
    });
  }
}
