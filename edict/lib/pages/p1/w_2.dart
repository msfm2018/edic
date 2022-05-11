import 'dart:async';
import 'dart:convert' as convert;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/net_provider.dart';
import '../global_controller.dart';
import 'data/data_provider.dart';
import 'entity/wordctable.dart';

final controller = Get.find<GlobalController>();
ScrollController _scrollController = ScrollController();

int page = 1;
var txtStyle = const TextStyle(
  fontSize: 38,
  fontWeight: FontWeight.w700,
  fontFeatures: <FontFeature>[FontFeature.enable('smcp')],
  color: Color.fromARGB(255, 90, 189, 235),
);

class W2 extends StatefulWidget {
  const W2({Key? key}) : super(key: key);

  @override
  State<W2> createState() => _W2State();
}

class _W2State extends State<W2> {
// class W2 extends StatelessWidget {
  // const W2({Key? key}) : super(key: key);
  @override
  void initState() {
    /// 为滚动控制器添加监听
    _scrollController.addListener(() {
      /// _scrollController.position.pixels 是当前像素点位置
      /// _scrollController.position.maxScrollExtent 当前列表最大可滚动位置
      /// 如果二者相等 , 那么就触发上拉加载更多机制
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        /// 触发上拉加载更多机制
        _loadMore();
      }
    });
    super.initState();
  }

  /// 上拉加载更多
  _loadMore() async {
    /// 强制休眠 1 秒
    const CircularProgressIndicator();
    await Future.delayed(const Duration(seconds: 10));
  }

  @override
  void dispose() {
    ///为了销毁ScrollController 所以使用 StatefulWidget
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Obx(
          () => controller.datas.isEmpty
              ? const Text('无数据')
              : ListView.builder(
                  controller: _scrollController,

                  /// 设置上拉加载更多
                  itemCount: controller.datas.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(
                        Icons.circle,
                        color: Color.fromARGB(25, 10, 10, 19),
                      ),
                      title: TextButton(
                          onPressed: () async {
                            //        IndexedStack  page
                            await DataProvider()
                                .onWordsRefresh2()
                                .then((value) {
                              controller.pageIndex = controller.pageIndex + 1;
                            });
                          },
                          child: Text(
                            controller.datas[index].groupname!,
                            style: txtStyle,
                          )),
                      trailing: Text(
                        controller.datas[index].id == 0 ? '未完成' : '已完成',
                        style: txtStyle,
                      ),
                    );
                  },
                ),
        )),
      ],
    );
  }
}
