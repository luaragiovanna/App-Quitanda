import 'package:get/get.dart';
import 'package:quitanda/src/pages/cart/controller/cart_controller.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    //injeta controller
    Get.put(CartController()); //injeta na memoria depois de passar pela autenticacao
  }
}
