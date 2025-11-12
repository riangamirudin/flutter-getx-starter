import 'package:flutter/material.dart';
import 'package:flutter_getx_starter/core/utils/styles/theme.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
