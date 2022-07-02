import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edict/package/toast/lib/toast.dart';

import 'global_controller.dart';
import 'p1/p1_home.dart';

final controller = Get.find<GlobalController>();

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.pageCurrentIndex.value,
          children: widgets,
        ),
      ),
      bottomNavigationBar: Obx(
        () => bottomTabs(),
      ),
    );
  }

  BottomNavigationBar bottomTabs() {
    return BottomNavigationBar(
      items: tabData
          .map(
            (item) => BottomNavigationBarItem(
              icon: Icon(
                item.image,
                size: 26,
                color: const Color.fromARGB(255, 102, 102, 102),
              ),
              activeIcon: Icon(
                item.selectedImage,
                size: 26,
                color: const Color.fromARGB(255, 224, 46, 36),
              ),
              label: item.title,
            ),
          )
          .toList(),
      currentIndex: controller.pageCurrentIndex.value,
      onTap: (index) {
        controller.pageCurrentIndex.value = index;
      },

      /// 图标和文本位置不变
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromARGB(255, 224, 46, 36),
      // item非选中
      unselectedItemColor: const Color(0xFF191919),
    );
  }
}

// ===========================================
List<Widget> widgets = [
  const P1Home(),
  CatalogPageInfo(),
  CatalogPageInfo(),
  CatalogPageInfo()
];
List tabData = [
  _TabBarItem('词条', Icons.home_max_outlined, Icons.home),
  _TabBarItem('生词本', Icons.book, Icons.book_online_outlined),
  _TabBarItem('搜索', Icons.car_rental_outlined, Icons.car_rental),
  _TabBarItem('设置', Icons.person_pin_circle_outlined, Icons.person_pin_circle),
];

class _TabBarItem {
  String title;
  IconData image, selectedImage;
  _TabBarItem(this.title, this.image, this.selectedImage);
}

class CatalogPageInfo extends StatefulWidget {
  CatalogPageInfo({Key? key}) : super(key: key);

  @override
  State<CatalogPageInfo> createState() => _CatalogPageInfoState();
}

class _CatalogPageInfoState extends State<CatalogPageInfo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("2222222222"),
    );
  }
}
