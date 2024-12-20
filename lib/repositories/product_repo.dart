import 'package:ecommerce_shop/models/product_response.dart';
import 'package:ecommerce_shop/services/network/api_response.dart';
import 'package:ecommerce_shop/services/network/api_services.dart';

class ProductRepository {
  final ApiServices _apiService;

  ProductRepository(this._apiService);

  Future<List<Product>> getProducts() async {
    try {
      final result = await _apiService.getProducts();
      if (result.status == Status.success) {
        final products = result.body as List;
        return products.map((p) => Product.fromJson(p)).toList();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
    return [];
  }

  Future<Product?> getProductsByID({required int id}) async {
    try {
      final result = await _apiService.getProductsById(id);
      if (result.status == Status.success) {
        return Product.fromJson(result.body);
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
    return null;
  }
}
