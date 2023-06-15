import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class HomeController extends GetxController {
  final customerInfo = Rx<CustomerInfo?>(null);
  final offerings = Rx<Offerings?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchInfo();
    fetchOffering();
  }

  void fetchInfo() async {
    customerInfo.value = await Purchases.getCustomerInfo();
  }

  void fetchOffering() async {
    try {
      offerings.value = await Purchases.getOfferings();
    } on PlatformException catch (e) {
      showMessage(e.toString());
    }
  }

  void purchase(Package package) async {
    try {
      customerInfo.value = await Purchases.purchasePackage(package);
      showMessage('Purchased');
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        showMessage('User cancelled');
      } else if (errorCode == PurchasesErrorCode.purchaseNotAllowedError) {
        showMessage('User not allowed to purchase');
      } else if (errorCode == PurchasesErrorCode.paymentPendingError) {
        showMessage('Payment is pending');
      }
    }
  }

  void showMessage(String message) {
    Get.showSnackbar(GetSnackBar(
      message: message,
      duration: const Duration(seconds: 3),
    ));
  }
}
