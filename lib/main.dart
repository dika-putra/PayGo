import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_go/home_controller.dart';
import 'package:pay_go/home_page.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import 'store_config.dart';

void main() async {
  const googleApiKey = String.fromEnvironment("ANDROID_API_KEY");
  StoreConfig(
    store: Store.playStore,
    apiKey: googleApiKey,
  );
  WidgetsFlutterBinding.ensureInitialized();
  await _configureSDK();
  runApp(const MyApp());
}

Future<void> _configureSDK() async {
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration configuration;
  if (StoreConfig.isForAmazonAppstore()) {
    configuration = AmazonConfiguration(StoreConfig.instance.apiKey);
  } else {
    configuration = PurchasesConfiguration(StoreConfig.instance.apiKey);
  }
  await Purchases.configure(configuration);

  await Purchases.enableAdServicesAttributionTokenCollection();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Pay Go',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController());
      }),
      home: const HomePage(),
    );
  }
}
