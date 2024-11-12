import 'package:ecommerce_shop/controllers/home/home_binding.dart';
import 'package:ecommerce_shop/controllers/product/product_binding.dart';
import 'package:ecommerce_shop/views/home/home_page.dart';
import 'package:ecommerce_shop/views/product/product_page.dart';
import 'package:get/route_manager.dart';

class Routes {
  static const INITIAL = '/home';

  static const PRODUCT = '/product';

  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PRODUCT,
      page: () => const ProductPage(),
      binding: ProductBinding(),
    ),
  ];
}
