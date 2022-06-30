import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global_controller.dart';
import 'data/data_provider.dart';

final controller = Get.find<GlobalController>();

class W1 extends StatelessWidget {
  const W1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 5),
          TextButton(
              onPressed: () async {
                await DataProvider().onGroupRefresh().then(
                    (value) => controller.pageIndex = controller.pageIndex + 1);
              },
              child: const Text(
                '计算机英语',
                style: TextStyle(
                    fontFamily: 'Cardo',
                    fontSize: 24,
                    fontFeatures: <FontFeature>[FontFeature.oldstyleFigures()]),
              )),
          // const Divider(),
          // TextButton(
          //     onPressed: () async {
          //     //  await DataProvider().onGroupRefresh().then((value) => controller.pageIndex = controller.pageIndex + 1);
          //     },
          //     child: const Text('化学英语',
          //         style: TextStyle(
          //           fontFamily: 'Cardo',
          //           fontSize: 24,
          //         ))),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}
