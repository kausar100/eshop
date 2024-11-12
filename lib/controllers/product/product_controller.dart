import 'package:ecommerce_shop/models/product_response.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var product = Product().obs;
  var productQuantity = 1.obs;
  @override
  void onInit() {
    final json = Get.arguments;
    product(Product.fromJson(json));
    super.onInit();
  }

  void changeQuantity(int newQuantity) {
    if (newQuantity < 1) {
      return;
    }
    productQuantity.value = newQuantity;
  }
}
