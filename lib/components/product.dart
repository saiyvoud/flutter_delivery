// ignore_for_file: prefer_const_constructors

import 'package:delivery/components/data.dart';
import 'package:delivery/controller/main_controller.dart';
import 'package:delivery/view/home/detail_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ProductComponent extends StatelessWidget {
  ProductComponent({super.key});

  final controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemCount: controller.productList.length,
      itemBuilder: (context, index) {
        var product = controller.productList[index];
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailProduct(
                    productModel: product,
                  ),
                ));
          },
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: 140,
                    width: double.infinity,
                    child: Image.network(
                      '${product.image}',
                      fit: BoxFit.cover,
                    )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${product.name}',
                        style: TextStyle(fontSize: 15),
                      ),
                      Text(
                        '${product.desc}',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        '${product.price.toString()} kip',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
