import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:okflutter/utils/AppPages.dart';
import 'package:okflutter/utils/Colours.dart';
import 'package:okflutter/utils/Messages.dart';
import 'package:okflutter/utils/MyNavigator.dart';

Widget loanApp() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..dismissOnTap = false
    ..userInteractions = false;
  return GetMaterialApp(
    translations: Messages(),
    fallbackLocale: const Locale('es', 'ES'),
    logWriterCallback: logWriterCallback,
    theme: ThemeData(primaryColor: Colours.appColor),
    themeMode: ThemeMode.light,
    initialRoute: '/splash',
    enableLog: false,
    getPages: AppPages.routes,
    initialBinding: BindingsBuilder(() {
      // Get.put(InitService());
      // Get.put(LoginStatusService());
      // Get.put(PayService());
    }),
    navigatorObservers: [MyNavigator()],
    builder: EasyLoading.init(),
  );
}

void logWriterCallback(String value, {bool isError = false}) {
  if (Get.isLogEnable) {
    if (isError) {
      // logger.e(value);
    } else {
      // logger.d(value);
    }
  }
}
