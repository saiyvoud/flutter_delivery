// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:delivery/components/banner.dart';
import 'package:delivery/components/product.dart';
import 'package:delivery/controller/cart_controller.dart';
import 'package:delivery/controller/main_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/menu.dart';
import '../profile/edit_profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(MainController());
  final cartcontroller = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return CircularProgressIndicator();
      } else {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.purple.shade500,
            leading: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfile())),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: controller.userModel[0].profile == ""
                      ? Image.asset(
                          "assets/icons/user.png",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "${controller.userModel[0].profile}",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            title: Text(
              "Monday Shopee",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            // title: Container(
            //   height: 50,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: Colors.white,
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 10),
            //     child: TextFormField(
            //       decoration: InputDecoration(
            //           hintText: "search ...",
            //           prefixIcon: Icon(Icons.search),
            //           border: InputBorder.none),
            //     ),
            //   ),
            // ),

            actions: [
              Center(
                child: Stack(
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.toNamed("/cart");
                        },
                        icon: Icon(Icons.shopping_cart)),
                    GetBuilder<CartController>(builder: (cartController) {
                      return Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "${cartController.cartModel.length}",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    controller.logout();
                  },
                  icon: Icon(Icons.exit_to_app)),
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
