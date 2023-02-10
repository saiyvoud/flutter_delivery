// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, unnecessary_brace_in_string_interps, avoid_print, deprecated_member_use, unused_element

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controller/main_controller.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  int id = 0;
  final MainController controller = Get.put(MainController());
  String? imgFile;
  File? file;

  Future chooseImage(ImageSource imageSource, BuildContext context) async {
    try {
      var object = await ImagePicker().getImage(
        source: imageSource,
      );
      setState(() {
        file = File(object!.path);
        selectFile(context);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> selectFile(BuildContext context) async {
    if (file == null) return;

    File fileName = File(file!.path);
    Uint8List imagebytes = await fileName.readAsBytes();
    String base64string = base64.encode(imagebytes);
    imgFile = "data:image/jpg;base64,$base64string";
    print('fileName:${imgFile}');
    setState(() {
      imgFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      _showDialog(context);
                    },
                    child: Container(
                      height: 110,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: file == null
                          ? controller.userModel[0].profile! == null ||
                                  controller.userModel[0].profile! == ""
                              ? Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )
                              : Image.network(
                                  controller.userModel[0].profile!,
                                  fit: BoxFit.cover,
                                )
                          : Image.file(
                              file!,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: firstName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'firstName is require';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'firstName',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: lastName,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'lastName enter desc';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'lastName',
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Container(
                      height: 50,
                      width: 200,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple)),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: const Text('Update Profile'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    chooseImage(ImageSource.gallery, context);
                  },
                  leading: Icon(Icons.camera),
                  title: Text("gallery"),
                ),
                ListTile(
                  onTap: () {
                    chooseImage(ImageSource.camera, context);
                  },
                  leading: Icon(Icons.camera_alt),
                  title: Text("camera"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'ຍົກເລີກ',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        );
      },
    );
  }
}
