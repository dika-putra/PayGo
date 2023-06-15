import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pay_go/home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text('Home')),
      ),
    );
  }
}