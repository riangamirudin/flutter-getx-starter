import 'package:flutter_getx_starter/app/global/utils.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Utils());
  }

}