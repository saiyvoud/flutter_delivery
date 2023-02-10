// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, unrelated_type_equality_checks

import 'package:delivery/controller/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/notfound.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  final CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cartController.isCartLoading.value) {
        return Scaffold(
          body: CircularProgressIndicator(),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: Text("Cart View"),
            centerTitle: true,
            backgroundColor: Colors.purple,
          ),
          bottomNavigationBar: cartController.totalPrice == 0
              ? Text('')
              : Container(
                  height: 100,
                  decoration: BoxDecoration(color: Colors.purple),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "ລາຄາ: ${cartController.totalPrice.toString()} Kip",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        InkWell(
                          onTap: () {
                            Get.toNamed("/payment");
                          },
                          child: Container(
                            height: 60,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Center(
                              child: Text(
                                "ຊຳລະເງີນ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          body: cartController.totalPrice == 0
              ? notFound()
              : ListView.builder(
                  itemCount: cartController.cartModel.length,
                  itemBuilder: (context, index) {
                    var data = cartController.cartModel[index];
                    return Card(
                      child: Row(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              "${data.img}",
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.name}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${data.desc}",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "${data.price} Kip",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      if (data.amount == 1) {
                                        Get.snackbar(
                                          "remove",
                                          "can not remove cart",
                                          backgroundColor: Colors.red,
                                          colorText: Colors.white,
                                        );
                                      } else {
                                        cartController.removeCart(
                                            id: data.cartID,
                                            amount: data.amount);
                                      }
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Icon(Icons.remove,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Text("${data.amount}"),
                                  SizedBox(width: 10),
                                  InkWell(
                                    onTap: () {
                                      cartController.addCart(
                                          id: data.cartID, amount: data.amount);
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                          child: Icon(Icons.add,
                                              color: Colors.white)),
                                    ),
                                  ),
                                  SizedBox(width: 100),
                                  IconButton(
                                    onPressed: () {
                                      cartController.deleteCart(
                                          id: data.cartID);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
        );
      }
    });
  }
}
