import 'package:get/get.dart';
import 'package:quitanda/src/pages/home/controller/home_controller.dart';

class HomeBiding extends Bindings {
  @override
  void dependencies() {
    //injetando as dependencias relacionadas ao home binding

    Get.put(HomeController());
    
  }
}
