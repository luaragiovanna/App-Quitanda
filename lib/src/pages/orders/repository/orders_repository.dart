import 'package:quitanda/src/constants/endpoints.dart';
import 'package:quitanda/src/models/cart_item_model.dart';
import 'package:quitanda/src/models/order_model.dart';
import 'package:quitanda/src/pages/orders/orders_result/orders_result.dart';
import 'package:quitanda/src/services/http_manager.dart';

class OrdersRepository {
  final _httpManager = HttpManager();

  Future<OrdersResult<List<OrderModel>>> getAllOrders(
      {required String userId, required String token}) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getAllOrders,
        method: HttpMethods.post,
        body: {
          'user': userId,
        },
        headers: {
          'X-Parse-Session-Token': token
        });
    if (result['result'] != null) {
      List<OrderModel> orders =
          List<Map<String, dynamic>>.from(result['result']) //conversao
              .map(OrderModel.fromJson) //tudo vai ficar num list de OrderModel
              .toList();

      return OrdersResult<List<OrderModel>>.success(orders);
    } else {
      return OrdersResult.error(
          'Nao foi possivel recuperar a lista de pedidos');
    }
  }

  Future<OrdersResult<List<CartItemModel>>> getOrderItems({
    required String orderId,
    required String token,
  }) async {
    final result = await _httpManager.restRequest(
        url: Endpoints.getOrderItems,
        method: HttpMethods.post,
        body: {
          'orderId': orderId
        },
        headers: {
          'X-Parse-Session-Token': token,
        });
    if (result['result'] != null) {
      List<CartItemModel> items =
          List<Map<String, dynamic>>.from(result['result'])
              .map(CartItemModel.fromJson)
              .toList();
      return OrdersResult<List<CartItemModel>>.success(items);
    } else {
      return OrdersResult.error(
          'Nao foi possivel recuperar produtos do pedido');
    }
  }
}
