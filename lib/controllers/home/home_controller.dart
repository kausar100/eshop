import 'package:ecommerce_shop/models/product_response.dart';
import 'package:ecommerce_shop/repositories/product_repo.dart';
import 'package:ecommerce_shop/shared/shared_widgets.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository _productProvider;
  HomeController(this._productProvider);

  var products = <Product>[].obs;
  var selectedProducts = <Product>[].obs;
  var categories = <String>{}.obs;
  var selectedType = 'ALL'.obs;

  @override
  void onInit() {
    getProducts();
    super.onInit();
  }

  void getProducts() {
    try {
      _productProvider.getProducts().then((result) {
        products(result);
        final typeOfProduct =
            result.map((e) => e.category.toString().toUpperCase()).toList();
        categories(typeOfProduct.toSet());
        categories.add('ALL');
      });
    } catch (error) {
      CommonWidgets.snackBar('error', error.toString());
    }
  }

  void changeSelectedProduct(String type) {
    selectedType(type);
    final result = products
        .where((e) => e.category.toString().toUpperCase() == type)
        .toList();
    selectedProducts(result);
  }
}
