import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:quitanda/src/pages/auth/view/sign_in_screen.dart';
import 'package:quitanda/src/pages/auth/view/sign_up_screen.dart';
import 'package:quitanda/src/pages/base/base_screen.dart';
import 'package:quitanda/src/pages/base/binding/navigation_binding.dart';
import 'package:quitanda/src/pages/cart/binding/cart_binding.dart';
import 'package:quitanda/src/pages/home/binding/home_biding.dart';
import 'package:quitanda/src/pages/orders/binding/orders_binding.dart';
import 'package:quitanda/src/pages/product/product_screen.dart';
import 'package:quitanda/src/pages/splash/splash_screen.dart';

abstract class AppPages {
  //vincular binding a telas
  static final pages = <GetPage>[
    GetPage(name: PagesRoutes.productRoute, page: () => ProductScreen()),
    GetPage(
      name: PagesRoutes.splashRoute,
      page: () => const SplashScreen(), //intancia da tela q queremos mapear)
    ),
    GetPage(
      name: PagesRoutes.signinRoute,
      page: () => SignInScreen(), //intancia da tela q queremos mapear)
    ),
    GetPage(
      name: PagesRoutes.signupRoute,
      page: () => SignUpScreen(), //intancia da tela q queremos mapear)
    ),
    GetPage(
        name: PagesRoutes.baseRoute,
        page: () => const BaseScreen(), //intancia da tela q queremos mapear)
        bindings: //indica binding especifico q injeta objetos especificos
            [
          HomeBiding(),
          NavigationBinding(),
          CartBinding(),
          OrdersBinding(), 
        ]),
  ];
}

abstract class PagesRoutes {
  static const String signinRoute = '/signin';
  static const String signupRoute = '/signup';
  static const String splashRoute = '/splash';
  static const String productRoute = '/product';
  static const String baseRoute = '/';
}
