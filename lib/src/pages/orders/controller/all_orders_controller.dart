import 'package:get/get.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda/src/pages/orders/repository/orders_repository.dart';
import 'package:quitanda/src/services/utils_services.dart';

class AllOrdersController extends GetxController {
  List<OrderModel> allOrders = [];
  final orderRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilsServices = UtilsServices();

  @override
  void onInit() {
    super.onInit();
    getAllOrders();
  }

  Future<void> getAllOrders() async {
    OrdersResult<List<OrderModel>> result = await orderRepository.getAllOrders(
        userId: authController.user.id!, token: authController.user.token!);
    //verificar o tipo q o metodo retorna
    result.when(success: (orders) {
      allOrders = orders;
      update();
    }, error: (message) {
      utilsServices.showToast(message: message, isError: true);
    });
  }
}
