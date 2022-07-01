import 'dart:convert';

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
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

  _fetchGroupData() async {
    var jsonData = {"table_id": "items"};
    String str = jsonEncode(jsonData);
    try {
      var response = await NetProvider().dio!.get('/api_items?' + str);
      var vv = GroupCTable.fromJson(response.data);
      return vv.data;
    } catch (e) {
      return "";
    }
  }

  Future<dynamic> onGroupRefresh() {
    controller.datasG.clear();
    return _fetchGroupData().then((dta) {
      controller.datasG.addAll(dta);
    });
  }

  _fetchWordData(startId, max) async {
    var jsonData = {"table_id": "item1", "start_id": '$startId', "max": '$max'};
    String str = jsonEncode(jsonData);
    var response = await NetProvider().dio!.get('/api_words?' + str);
    var vv = WordCTable.fromJson(response.data);
    return vv.data;
  }

  ///上拉请求数据
  Future<dynamic> onRefreshUp(int startId, int max) {
    if (startId == 0) {
      controller.datasWord.clear();
    }
    return _fetchWordData(startId, max).then((dta) {
      controller.datasWord.addAll(dta);
    });
  }

  Future<http.Response> sendPost2(String id) async {
    var post = {"table_id": "item1", "id": id};

    var body = utf8.encode(json.encode(post));

    var addPost = await http.post(Uri.http(ip, 'api_delword'),
        headers: {"content-type": "application/json"}, body: body);
    return addPost;
  }

  sendPost(String id) async {
    var post = {"table_id": "item1", "id": id};

    String body = jsonEncode(post);

    // NetProvider().dio!.options.contentType = Headers.formUrlEncodedContentType;
    var response = await NetProvider().dio!.post(
          '/api_delword',
          data: body,
          options: Options(
            contentType: Headers.jsonContentType,
          ),
        );
    var resCall = response.data;
    print(resCall);
  }

  Future<void> onDelWord(String id) {
    return sendPost(id);
  }
}
