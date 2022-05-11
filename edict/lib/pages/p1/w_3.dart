import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../global_controller.dart';

int page = 1;
final controller = Get.find<GlobalController>();

void setSource(Source source) async {
  await player.play(source);
}

final TextStyle titleStyle = TextStyle(
  fontSize: 18,
  fontFeatures: const <FontFeature>[FontFeature.enable('smcp')],
  color: Colors.blueGrey[600],
);
AudioPlayer player = AudioPlayer();

class W3 extends StatelessWidget {
  const W3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print(Get.arguments);
    // print(Get.parameters['name']);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Obx(
          () => controller.datasWord.isEmpty
              ? const Text('无数据')
              : ListView.builder(
                  itemCount: controller.datasWord.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.play_circle),
                            iconSize: 20,
                            onPressed: () => setSource(UrlSource(
                                'https://sp1.baidu.com/-rM1hT4a2gU2pMbgoY3K/gettts?lan=en&text=${controller.datasWord[index].wordname!}&spd=2&source=alading')),
                          ),
                          TextButton(
                              onPressed: () {},
                              child:
                                  Text(controller.datasWord[index].wordname!)),
                          Text('[音标]'),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: Text(
                              controller.datasWord[index].wordtrans!,
                              textAlign: TextAlign.left, // 对齐方式
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          )
                              // child: Text(
                              //   controller.datasWord[index].wordtrans!,
                              //   textAlign: TextAlign.left, // 对齐方式
                              //   overflow: TextOverflow.ellipsis,
                              //   maxLines: 3,
                              // ), // 对齐方式),
                              ),
                        ],
                      ),
                      subtitle: const Divider(),
                      // trailing: Text(controller.datasWord[index].wordtrans!),
                    );
                  },
                ),
        )),
      ],
    );
  }
}
