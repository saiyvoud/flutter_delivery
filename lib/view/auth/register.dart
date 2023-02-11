// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../controller/main_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final form = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool eye = true;
  final MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: form,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Image.asset("assets/images/Fingerprint-bro.png", height: 200),
                Text(
                  "Create your Account",
                  style: TextStyle(fontSize: 18),
                ),
                TextFormField(
                  controller: firstName,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "firstName is require";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "firstName",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                TextFormField(
                  controller: lastName,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "lastName is require";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "lastName",
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "email is require";
                    } else if (!value.contains('@gmail.com')) {
                      return "ຕ້ອງມີ @gmail.com";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email@gmail.com",
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                TextFormField(
                  controller: password,
                  obscureText: eye,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "password is require";
                    } else if (value.length < 6) {
                      return "password must not 6 more";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: "password",
                      prefixIcon: Icon(Icons.key),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.visibility),
                        onPressed: () {
                          setState(() {
                            eye = !eye;
                          });
                        },
                      )),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (form.currentState!.validate()) {
                      controller.register(firstName.text, lastName.text,
                          email.text, password.text);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
