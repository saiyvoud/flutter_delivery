// ignore_for_file: prefer_const_constructors

import 'package:delivery/controller/main_controller.dart';
import 'package:delivery/view/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showPassword = true;
  final form = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
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
                  "Login your Account",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
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
                  obscureText: showPassword,
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
                            showPassword = !showPassword;
                          });
                        },
                      )),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    if (form.currentState!.validate()) {
                      controller.login(email.text, password.text);
                    }
                  },
                  child: Container(
                    height: 60,
                    width: 200,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Register())));
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
