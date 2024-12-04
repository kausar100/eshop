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
    try {
      _checkConnectivity();
      _subscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    } catch (err) {
      print('\n---------------Internet connectivity error--------------\n');
    }
  }

  Future<void> _checkConnectivity() async {
    try {
      var result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (err) {
      rethrow;
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> result) {
    try {
      isConnected.value = !result.contains(ConnectivityResult.none);
      print(
          "\n----------------Internet Available : ${isConnected.value}--------------\n");
      if (Get.isSnackbarOpen) {
        Get.closeCurrentSnackbar();
      }
      if (!isConnected.value) {
        CommonWidgets.snackBar('error',
            'Please Check your internet connection!', const Duration(days: 1));
      }
    } catch (err) {
      rethrow;
    }
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
