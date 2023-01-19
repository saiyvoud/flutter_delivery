// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class AddTime extends StatefulWidget {
  const AddTime({super.key});

  @override
  State<AddTime> createState() => _AddTimeState();
}

class _AddTimeState extends State<AddTime> {
  final day = TextEditingController();
  final time = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('ເພີ່ມວັນທີ່ ແລະ ເວລາຈັດສົ່ງ'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {},
          child: Container(
            height: 50,
            decoration: BoxDecoration(
                color: Colors.purple, borderRadius: BorderRadius.circular(10)),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "ວັນທີ່ຈັດສົ່ງ",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "ວັນທີ່ຈັດສົ່ງ";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      )),
                  hintText: "ວັນທີ່ຈັດສົ່ງ",
                ),
              ),
              SizedBox(height: 10),
              Text(
                "ເວລາທີ່ຈັດສົ່ງ",
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                maxLines: 3,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "ເວລາຈັດສົ່ງ";
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                    borderSide: BorderSide(
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        width: 1,
                        color: Colors.red,
                      )),
                  hintText: "ເວລາຈັດສົ່ງ",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
