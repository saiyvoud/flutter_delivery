// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors

import 'package:delivery/controller/cart_controller.dart';
import 'package:delivery/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  const DetailProduct({super.key, required this.productModel});

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: () async {
          await cartController.addProductToCart(
            productID: widget.productModel.productID.toString(),
            name: widget.productModel.name.toString(),
            desc: widget.productModel.desc.toString(),
            amount: widget.productModel.amount!,
            price: widget.productModel.price!,
            img: widget.productModel.image.toString(),
          );
        },
        child: Container(
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), color: Colors.green),
              child: Center(
                child: Text(
                  "Add Product",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: (() => Get.back()),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GetBuilder<CartController>(builder: (cartController) {
                    if (cartController.isCartLoading.value) {
                      return CircularProgressIndicator();
                    } else {
                      return Stack(
                        children: [
                          InkWell(
                            onTap: () => Get.toNamed("/cart"),
                            child: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.white,
                              ),
                              child: Icon(
                                Icons.shopping_cart,
                                size: 30,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 1,
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
                              )),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
                ],
              ),
            ),
            Center(
              child: Container(
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    "${widget.productModel.image}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Icon(Icons.list_alt, color: Colors.purple),
                SizedBox(width: 10),
                Text(
                  "ລາຍລະອຽດສິນຄ້າ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "${widget.productModel.name}",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              "${widget.productModel.desc}",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            Text(
              "ຈຳນວນສິນຄ້າ: ${widget.productModel.amount.toString()} ຄູ່",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
            Text(
              "${widget.productModel.price.toString()} ₭",
              style: TextStyle(
                  fontSize: 20, color: Colors.red, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.motorcycle, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  "ລາຍລະອຽດການຈັດສົ່ງ",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              "ເຮົາຈະມາຮູ້ພ້ອມກັນວ່າມື້ນີ້ໃຜຈະໄດ້ເປັນຜູ້ໂຊກດີຮັບຂອງລາງວັນຈາກການສະຫຼອງ  ຟູດແພນດ້າ ຄົບຮອບ 3 ປີລວມມູນຄ່າຂອງລາງວັນທັງໝົດເຖິງ 120,000,000 ກີບ! 🤩 ພ້ອມກັບແຂກຮັບເຊີນສຸດພິເສດຂອງເຮົາ Olay ແລະ Jay ຈາກ Reeriew ທີ່ຈະພາທຸກຄົນມາຫຼີ້ນເກມມ່ວນໆ! ແທັກໝູ່ມາເບີ່ງ LIVE ດ່ວນເພາະທ່ານອາດເປັນຜູ້ໂຊກດີຄົນນັ້ນ! 🤗",
              style: TextStyle(fontSize: 15, color: Colors.black),
            ),
          ],
        ),
      )),
    );
  }
}
