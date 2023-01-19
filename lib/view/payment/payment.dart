// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_collection_literals

import 'package:delivery/controller/cart_controller.dart';
import 'package:delivery/controller/location_controller.dart';
import 'package:delivery/model/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/main_controller.dart';
import '../../controller/order_controller.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  final LocationController locationController = Get.put(LocationController());
  final MainController mainController = Get.put(MainController());
  final CartController cartController = Get.put(CartController());
  final OrderController orderController = Get.put(OrderController());
  @override
  void initState() {
    super.initState();
    locationController.getLocation();
    mainController.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (locationController.locationLoading.value) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.purple,
            title: const Text(
              "Payment",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          bottomNavigationBar: InkWell(
            onTap: () {
              orderController.saveOrder(
                  orderModel: OrderModel(
                locationList: locationController.locationList,
                cartList: cartController.cartModel,
                totalPice: cartController.totalPrice.toString(),
                createdAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString(),
                userId: FirebaseAuth.instance.currentUser!.uid,
              ));
            },
            child: Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.purple),
              child: Center(
                child: Text(
                  "ຊຳລະເລີຍ",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.call, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      "ຊ່ອງທາງຕິດຕໍ່",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5),
                GetBuilder<MainController>(builder: (controller) {
                  if (mainController.userLoading.value) {
                    return CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ຊື່ ແລະ ນາມສະກຸນ"),
                          Text(
                              "${controller.userModel[0].firstName} ${controller.userModel[0].lastName}"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ເບີໂທຕິດຕໍ່"),
                          Text("+856 20 12345678"),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("ອີເມວຕິດຕໍ່"),
                          Text("${controller.userModel[0].email}"),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                }),

                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.time_to_leave, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      "ເວລາຈັດສົ່ງສິນຄ້າ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ວັນທີ່ຈັດສົ່ງ"),
                        Text("${locationController.locationList[0].day}"),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("ເວລາຈັດສົ່ງ"),
                        Text("${locationController.locationList[0].time}"),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.map, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      "ສະຖານທີ່ຈັດສົ່ງສິນຄ້າ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.amber),
                      onPressed: () {
                        Get.toNamed("/address");
                      },
                    ),
                  ],
                ),
                locationController.locationList.length == 0
                    ? InkWell(
                        onTap: () {
                          Get.toNamed('/address');
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.purple,
                          ),
                          child: Center(
                            child: Text(
                              'ເພີ່ມທີ່ຢູ່ຈັດສົ່ງ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("ບ້ານ ເມືອງ ແຂວງ"),
                              Text(
                                  "${locationController.locationList[0].address}"),
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("ປະເພດທີ່ຢູ່ອາໄສ"),
                              Text(
                                  "${locationController.locationList[0].type}"),
                            ],
                          ),
                          SizedBox(height: 5),
                          Container(
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.purple,
                            ),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                zoom: 16,
                                target: LatLng(
                                  locationController
                                      .locationList[0].location!.latitude,
                                  locationController
                                      .locationList[0].location!.longitude,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                SizedBox(height: 10),

                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.list_alt, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      "ລາຍລະອຽດສິນຄ້າ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ຊື່"),
                    Text("ຈຳນວນ"),
                    Text("ລາຄາ"),
                  ],
                ),
                SizedBox(height: 5),
                GetBuilder<CartController>(builder: (controller) {
                  if (cartController.isCartLoading.value) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      itemCount: controller.cartModel.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = controller.cartModel;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${data[index].name}"),
                            Text("${data[index].amount.toString()}"),
                            Text("${data[index].price.toString()} Kip"),
                          ],
                        );
                      });
                }),

                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ລາຄາລວມ"),
                    GetBuilder<CartController>(builder: (controller) {
                      if (cartController.isCartLoading.value) {
                        return CircularProgressIndicator();
                      }
                      return Text(
                        "${controller.totalPrice.toString()} Kip",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      );
                    }),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 10,
                  decoration: BoxDecoration(color: Colors.grey.shade50),
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.money_off, color: Colors.purple),
                    SizedBox(width: 10),
                    Text(
                      "ປະເພດການຊຳລະ",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Icon(Icons.edit, color: Colors.amber),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("ປະເພດການຊຳລະ"),
                    Text(
                      "ຈ່າຍປາຍທາງ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                // Container(
                //   height: 50,
                //   width: 200,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(10),
                //     border: Border.all(
                //       color: Colors.grey,
                //     ),
                //   ),
                //   child: Center(
                //     child: Text(
                //       "ຈ່າຍປາຍທາງ",

                //     ),
                //   ),
                // ),
              ],
            ),
          )),
        );
      }
    });
  }
}
