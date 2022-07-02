import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:edict/pages/p1/entity/wordctable.dart';

import 'package:get/get.dart';
import 'package:edict/package/toast/lib/toast.dart';
import '../global_controller.dart';
import 'data/data_provider.dart';

int page = 1;

final controller = Get.find<GlobalController>();
ScrollController _scrollController = ScrollController();
void setSource(Source source) async {
  await player.play(source);
}

final TextStyle titleStyle = TextStyle(
  fontSize: 18,
  fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
  color: Colors.blueGrey[600],
);
AudioPlayer player = AudioPlayer();

class W3 extends StatefulWidget {
  const W3({Key? key}) : super(key: key);

  @override
  State<W3> createState() => _W3State();
}

class _W3State extends State<W3> {
  Future<void> _loadMore() async {
    Future.delayed(const Duration(milliseconds: 1000), () async {
      try {
        await DataProvider()
            .onRefreshUp(controller.startId, controller.max)
            .then((value) {
          controller.ishide.value = true;
          controller.startId = controller.startId + controller.max;
        });
      } catch (e) {
        controller.ishide.value = true;
      }
    });
  }

  @override
  void initState() {
    _scrollController.addListener(() async {
      /// _scrollController.position.pixels 是当前像素点位置
      /// _scrollController.position.maxScrollExtent 当前列表最大可滚动位置   上拉加载
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        controller.ishide.value = false;
        await _loadMore();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: RefreshIndicator(
                onRefresh: () async {
                  ///下拉加载
                  controller.startId = 0;
                  await _loadMore();
                  return Future.value();
                },
                child: Obx(
                  () => controller.datasWord.isEmpty
                      ? const Text('无数据')
                      : ListView.builder(
                          controller: _scrollController,
                          itemCount: controller.datasWord.length,
                          itemBuilder: (context, index) {
                            final item = controller.datasWord[index];

                            // background 是向右滑动展示的，secondaryBackground是向左滑动展示的。
                            return Dismissible(
                              key: Key(item.wordname!),
                              onDismissed: (direction) async {
                                var _snackStr = '';
                                if (direction == DismissDirection.endToStart) {
                                  // 从右向左  也就是删除
                                  _snackStr = '删除了${item.wordname}';
                                } else if (direction ==
                                    DismissDirection.startToEnd) {
                                  _snackStr = '收藏了${item.wordname}';
                                }

                                // // 展示 SnackBar
                                // ScaffoldMessenger.of(context)
                                //     .showSnackBar(SnackBar(
                                //   content: Text(_snackStr),
                                // ));

                                showToast(_snackStr,
                                    duration: 2, gravity: Toast.bottom);

                                controller.datasWord.removeAt(index);
                                await DataProvider().onDelWord(item.wordname!);
                              },
                              background: Container(),

                              //向左滑动
                              secondaryBackground: Container(
                                color: Colors.redAccent,
                                // 这里使用 ListTile 因为可以快速设置左右两端的Icon
                                child: const ListTile(
                                  trailing: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 1.5),
                                  child: ListTile(
                                    title: Text(item.wordname!),
                                    subtitle: Text(item.wordtrans!),
                                    leading: IconButton(
                                      icon: const Icon(Icons.play_circle),
                                      iconSize: 20,
                                      onPressed: () => setSource(UrlSource(
                                          'https://sp1.baidu.com/-rM1hT4a2gU2pMbgoY3K/gettts?lan=en&text=${controller.datasWord[index].wordname!}&spd=2&source=alading')),
                                    ),

                                    ////
                                    trailing: Text(
                                        controller.datasWord[index].tone ?? ""),
                                  )),

                              ///
                              confirmDismiss:
                                  (DismissDirection dismissDirection) async {
                                switch (dismissDirection) {
                                  case DismissDirection.endToStart:
                                    return await _showConfirmationDialog(
                                            context, '删除', item) ==
                                        true;
                                  case DismissDirection.startToEnd:

                                  // return false;
                                  case DismissDirection.horizontal:
                                  case DismissDirection.vertical:
                                  case DismissDirection.up:
                                  case DismissDirection.down:
                                    return false;
                                  case DismissDirection.none:
                                    break;
                                }
                                return false;
                              },
                            );
                          },
                        ),
                ))),
        Obx(
          () {
            return Offstage(
              offstage: controller.ishide.value,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        '努力加载中...',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color(0xFF333333),
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(left: 10)),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 3),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void showToast(String msg, {int? duration, int? gravity}) {
    Toast.show(msg, duration: duration, gravity: gravity);
  }
}

Future<bool?> _showConfirmationDialog(
    BuildContext context, String action, DataWord dw) async {
  if (action == '删除') {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(' $action?'),
          actions: <Widget>[
            TextButton(
              child: const Text('是'),
              onPressed: () {
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
            TextButton(
              child: const Text('否'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
          ],
        );
      },
    );
  } else {
    return null;
  }
}
