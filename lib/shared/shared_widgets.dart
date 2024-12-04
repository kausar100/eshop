import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonWidgets {
  static void snackBar(String type, String message, Duration? duration) async {
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.snackbar(type, message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: type == 'error' ? Colors.red : Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
        duration: duration ?? const Duration(seconds: 2),
        icon: const Icon(Icons.error, color: Colors.white));
  }

  static void showSuccessToast(String title, String message) async {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }
}
