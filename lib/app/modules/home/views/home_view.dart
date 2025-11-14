import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_getx_starter/core/widgets/default_button.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('app_name'.tr),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter Display
            Obx(() => Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.blue.shade200),
              ),
              child: Column(
                children: [
                  Text(
                    'Counter',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    '${controller.count.value}',
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )),
            SizedBox(height: 32.h),
            
            // Increment Button
            DefaultButton(
              text: 'add'.tr,
              icon: Icons.add,
              size: ButtonSize.small,
              onPressed: () => controller.increment(),
            ),
            SizedBox(height: 16.h),
            
            // Language Toggle Section
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.grey[600],
                        size: 24.sp,
                      ),
                      SizedBox(width: 12.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bahasa / Language',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Obx(() => Text(
                            controller.isIndonesian.value 
                                ? 'Bahasa Indonesia' 
                                : 'English',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: Colors.grey[600],
                            ),
                          )),
                        ],
                      ),
                    ],
                  ),
                  Obx(() => Switch(
                    value: controller.isIndonesian.value,
                    onChanged: (value) => controller.toggleLanguage(value),
                    activeColor: Colors.blue,
                  )),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            
            // Reset Counter Button
            DefaultButton(
              text: 'retry'.tr,
              icon: Icons.refresh,
              type: ButtonType.outline,
              size: ButtonSize.large,
              onPressed: () => controller.count.value = 0,
            ),
          ],
        ),
      ),
    );
  }
}
