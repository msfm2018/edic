import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controller.dart';
import 'data/data_provider.dart';

final controller = Get.find<GlobalController>();
ScrollController _scrollController = ScrollController();

int page = 1;
var txtStyle = const TextStyle(
  fontSize: 18,
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
    print('准备加载数据');
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Obx(
          () => controller.datasG.isEmpty
              ? const Text('无数据')
              : ListView.builder(
                  controller: _scrollController,

                  /// 设置上拉加载更多
                  itemCount: controller.datasG.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: TextButton(
                          onPressed: () async {
                            //        IndexedStack  page
                            try {
                              await DataProvider()
                                  .onRefreshUp(
                                      controller.startId, controller.max)
                                  .then((value) {
                                controller.startId =
                                    controller.startId + controller.max;
                                controller.pageIndex = controller.pageIndex + 1;
                                if (controller.pageIndex > 2) {
                                  controller.pageIndex = 2;
                                }
                              });
                            } catch (e) {
                              controller.pageIndex = controller.pageIndex;
                            }
                          },
                          child: Text(
                            controller.datasG[index].groupname!,
                            style: txtStyle,
                          )),
                    );
                  },
                ),
        )),
      ],
    );
  }
}
