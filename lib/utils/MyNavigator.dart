import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'Routes.dart';

class MyNavigator extends NavigatorObserver {
  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    String? previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    } else {
      previousName = previousRoute.settings.name;
    }
    Get.log('Xing----->NavObserverDidPop--Current: ${route.settings.name}' +
        '  Previous:${previousName}');
    // if (previousName == Routes.MAIN) {
    //   // refreshHomeData();
    // }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    String? previousName = '';
    if (previousRoute == null) {
      previousName = 'null';
    } else {
      previousName = previousRoute.settings.name;
    }
    Get.log('Xing-------NavObserverDidPush-Current: ${route.settings.name}' +
        '  Previous: $previousName');
  }
}
