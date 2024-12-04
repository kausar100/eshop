import 'package:ecommerce_shop/controllers/internet/network_controller.dart';
import 'package:ecommerce_shop/models/product_response.dart';
import 'package:ecommerce_shop/repositories/product_repo.dart';
import 'package:ecommerce_shop/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository _productProvider;
  final _networkManager = Get.find<NetworkManager>();
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
    if (_networkManager.isConnected.value) {
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
    } else {
      CommonWidgets.snackBar('error', 'Please check your internet connection!');
    }
  }

  void getProductsByProductID({required int id}) {
    if (_networkManager.isConnected.value) {
      try {
        _productProvider.getProductsByID(id: id).then((p) {
          if (p != null) {
            Get.dialog(FittedBox(
              child: Image.network(p.image.toString()),
            ));
          }
        });
      } catch (error) {
        CommonWidgets.snackBar('error', error.toString());
      }
    } else {
      CommonWidgets.snackBar('error', 'Please check your internet connection!');
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
