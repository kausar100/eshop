import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecommerce_shop/shared/shared_widgets.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  var isConnected = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
    _subscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> _checkConnectivity() async {
    var result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    isConnected.value = !result.contains(ConnectivityResult.none);
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    if (!isConnected.value) {
      CommonWidgets.snackBar('error', 'Please Check your internet connection!',
          const Duration(days: 1));
    }
    print(
        "\n----------------Internet Available : ${isConnected.value}--------------\n");
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
