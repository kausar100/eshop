import 'package:dio/dio.dart';
import 'package:ecommerce_shop/services/network/api_constants.dart';

class DioClient {
  DioClient._() {
    final options = BaseOptions(
      headers: {
        "Connection": "Keep-Alive",
        "Keep-Alive": "timeout=60, max=1000"
      },
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 60),
      receiveTimeout: const Duration(seconds: 60),
      // validateStatus: (status) {
      //   return (status == 400 ||
      //       status == 401 ||
      //       status == 404 ||
      //       status == 405 ||
      //       status == 200 ||
      //       status == 201 ||
      //       status == 204 ||
      //       status == 500);
      // },
    );

    _dio = Dio(options);
    _dio.interceptors
        .add(LogInterceptor(requestBody: true, responseBody: true));
  }

  static final DioClient _instance = DioClient._();

  late Dio _dio;

  Dio get dio => _dio;

  factory DioClient() {
    return _instance;
  }
}
