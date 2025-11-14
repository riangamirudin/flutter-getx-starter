import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_getx_starter/core/config/app_config.dart';
import 'package:flutter_getx_starter/core/utils/styles/theme.dart';
import 'package:flutter_getx_starter/core/utils/logger/app_logger.dart';
import 'package:flutter_getx_starter/core/utils/hive/storage_service.dart';
import 'package:flutter_getx_starter/core/localization/app_translations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Load .env file
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    // Jika .env tidak ditemukan, gunakan default values
    print('Warning: .env file not found, using default values');
  }
  
  // Initialize Hive untuk Flutter
  await Hive.initFlutter();
  
  // Initialize HiveService
  await HiveService.init();
  
  // Initialize logger dengan package name dari device
  await AppLogger.init();
  
  // Initialize AppConfig dari .env
  AppConfig.init();
  
  runApp(
    ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: const Size(360, 690),
      builder: (_, __) {
        // Load saved language preference
        final savedLanguage = HiveService.read('language') ?? 'id_ID';
        final localeParts = savedLanguage.split('_');
        final locale = Locale(localeParts[0], localeParts.length > 1 ? localeParts[1] : null);
        
        return GetMaterialApp(
          title: "Application",
          debugShowCheckedModeBanner: false,
          theme: themeData,
          // Setup translations
          translations: AppTranslations(),
          locale: locale,
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
        );
      }
    ),
  );
}
