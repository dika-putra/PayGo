import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_go/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(() {
            final customerInfo = controller.customerInfo.value;
            final packages =
                controller.offerings.value?.current?.availablePackages ?? [];
            return Column(
              children: [
                Text(
                    'Subscription is premium: ${customerInfo?.entitlements.active.containsKey('premium')}'),
                const SizedBox(height: 16),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final package = packages[index];
                    return ListTile(
                      title: Text(package.identifier),
                      tileColor: Colors.amber,
                      onTap: () {
                        controller.purchase(package);
                      },
                    );
                  },
                  itemCount: packages.length,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
