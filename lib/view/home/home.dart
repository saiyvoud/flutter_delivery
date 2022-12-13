// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:delivery/components/banner.dart';
import 'package:delivery/components/product.dart';
import 'package:delivery/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../../components/menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(MainController());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator();
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.shade500,
            title: Container(
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      hintText: "search ...",
                      prefixIcon: Icon(Icons.search),
                      border: InputBorder.none),
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(height: 10),
              BannerComponents(),
              SizedBox(height: 20),
              MenuComponent(),
              SizedBox(height: 10),
              Text(
                "Product Recommand",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              ProductComponent(),
            ],
          )),
        );
      }
    });
  }
}
