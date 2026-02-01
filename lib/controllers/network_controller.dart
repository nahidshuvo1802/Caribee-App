import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _checkInitialConnection();
  }

  Future<void> _checkInitialConnection() async {
    final results = await _connectivity.checkConnectivity();
    _updateConnectionStatus(results);
  }

  Future<void> _updateConnectionStatus(
      List<ConnectivityResult> connectivityResultList) async {
    // Check if there is any valid connection interface
    bool hasConnectionInterface = connectivityResultList
        .any((result) => result != ConnectivityResult.none);

    if (hasConnectionInterface) {
      // If there is a connection interface, check for actual internet access
      bool isDeviceConnected =
          await InternetConnectionChecker.instance.hasConnection;
      if (isDeviceConnected) {
        if (Get.isSnackbarOpen) {
          Get.closeCurrentSnackbar();
        }
        return; // Connection is good
      }
    }

    // If we are here, there is no internet
    if (!Get.isSnackbarOpen) {
      Get.rawSnackbar(
          messageText: const Text(
            'PLEASE CONNECT TO THE INTERNET',
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
          isDismissible: false,
          duration: const Duration(days: 1),
          backgroundColor: Colors.red[400]!,
          icon: const Icon(
            Icons.wifi_off,
            color: Colors.white,
            size: 35,
          ),
          margin: EdgeInsets.zero,
          snackStyle: SnackStyle.GROUNDED);
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
