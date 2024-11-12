import 'package:dio/dio.dart';
import 'package:ecommerce_shop/services/network/api_constants.dart';
import 'package:ecommerce_shop/services/network/api_response.dart';

import 'dio_client.dart';

class ApiServices {
  final DioClient _dioClient;

  ApiServices(this._dioClient);

  Future<ApiResponse> getProducts() async {
    try {
      Response response = await _dioClient.dio.get(ApiConstants.products);
      return handleResponse(response);
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  ApiResponse handleResponse(Response response) {
    ApiResponse result = ApiResponse();
    switch (response.statusCode) {
      case 201:
      case 200:
        result.setStatus = Status.success;
        result.setSuccessMsg = response.statusMessage;
        result.setBody = response.data;
        break;

      default:
        result.setStatus = Status.failed;
        result.setError = response.statusMessage;
    }

    return result;
  }
}
