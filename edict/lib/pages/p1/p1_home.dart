import 'package:edict/pages/p1/w_3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controller.dart';
import 'w_1.dart';
import 'w_2.dart';
import 'w_3.dart';

final controller = Get.find<GlobalController>();

class P1Home extends StatelessWidget {
  const P1Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('英语学习'),
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                controller.pageIndex <= 0 ? 0 : controller.pageIndex--;
                if (controller.pageIndex < 0) controller.pageIndex = 0;
                print(controller.pageIndex.toString());
              },
            ),
          ),
          body: Obx(() => IndexedStack(
                children: const [W1(), W2(), W3()],
                index: controller.pageIndex,
              ))),
    );
  }
}
