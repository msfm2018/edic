import 'package:get/get.dart';

import '../pages/home_view.dart';
import '../pages/global_binding.dart';

part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: GlobalBinding(),
    ),
  ];
}
