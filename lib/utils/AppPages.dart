import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:okflutter/FirbaseTestPage.dart';

import 'Routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => FirbaseTestPage(),
      preventDuplicates: true,
      transition: Transition.fade,
    )
  ];
}
