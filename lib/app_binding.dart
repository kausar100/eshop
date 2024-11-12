import 'package:ecommerce_shop/services/network/api_services.dart';
import 'package:ecommerce_shop/services/network/dio_client.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DioClient(), permanent: true);
    Get.put(ApiServices(Get.find()), permanent: true);
  }
}
