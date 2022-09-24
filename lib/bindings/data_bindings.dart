import 'package:flutter_exercise/controllers/home_controller.dart';
import 'package:get/get.dart';

class DataBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }

}