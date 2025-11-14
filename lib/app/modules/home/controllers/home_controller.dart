import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_getx_starter/core/utils/hive/storage_service.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  final RxBool isIndonesian = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadLanguagePreference();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  /// Load language preference dari storage
  void _loadLanguagePreference() {
    final savedLanguage = HiveService.read('language') ?? 'id_ID';
    isIndonesian.value = savedLanguage.startsWith('id');
  }

  /// Toggle bahasa antara Indonesia dan English
  void toggleLanguage(bool isId) {
    isIndonesian.value = isId;
    final newLocale = isId 
        ? const Locale('id', 'ID') 
        : const Locale('en', 'US');
    
    Get.updateLocale(newLocale);
    HiveService.write('language', 
        '${newLocale.languageCode}_${newLocale.countryCode}');
  }
}
