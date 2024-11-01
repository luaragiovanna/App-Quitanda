const String baseUrl = 'https://parseapi.back4app.com/functions';

abstract class Endpoints {
  //baseurl/method
  static const String sigin = '$baseUrl/login';
  static const String signup = '$baseUrl/signup';
  static const String validateToken = '$baseUrl/validate-token';
  static const String resetPassword = '$baseUrl/reset-password';
  static const String getAllCategories =
      '$baseUrl/get-category-list'; //tava errada  a rota
  static const String getAllProducts =
      '$baseUrl/get-product-list'; //recuperacao
  static const String getCartItems = '$baseUrl/get-cart-items';
  static const String addItemToCart = '$baseUrl/add-item-to-cart';
  static const String changeItemQuantity = '$baseUrl/modify-item-quantity';
  static const String checkout = '$baseUrl/checkout';
  static const String getAllOrders = '$baseUrl/get-orders';
  static const String getOrderItems = '$baseUrl/get-orders-items';
  static const String changePassword = '$baseUrl/change-password';
}
