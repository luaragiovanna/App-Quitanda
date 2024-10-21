import 'package:get/get.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/auth/controller/auth_controller.dart';
import 'package:quitanda/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda/src/pages/orders/repository/orders_repository.dart';
import 'package:quitanda/src/services/utils_services.dart';

class OrderController extends GetxController {
  OrderModel order;
  OrderController(this.order);
  bool isLoading = false;
  final ordersRepository = OrdersRepository();
  final authController = Get.find<AuthController>();
  final utilservices = UtilsServices();

  Future<void> getOrderItems() async {
    setLoading(true);
    final OrdersResult<List<CartItemModel>> result = await ordersRepository
        .getOrderItems(orderId: order.id, token: authController.user.token!);
    setLoading(false);
    result.when(success: (items) {
      order.items;
      update();
    }, error: (message) {
      utilservices.showToast(message: message, isError: true);
    });
  }

  void setLoading(bool value) {
    isLoading = value;
    update();
  }
}
