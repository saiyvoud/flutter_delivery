// ignore_for_file: prefer_const_constructors, avoid_print, prefer_collection_literals, deprecated_member_use, prefer_void_to_null

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delivery/controller/location_controller.dart';
import 'package:delivery/model/location_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class Address extends StatefulWidget {
  const Address({super.key});

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final address = TextEditingController();
  final day = TextEditingController();
  final time = TextEditingController();
  GeoPoint? location;
  final LocationController locationController = Get.put(LocationController());
  LocationData? currentLocation;
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor? _markerIcon;
  double? lat, lng;

  List<String> item = [
    'ບ້ານ',
    'ທີ່ທຳງານ',
  ];
  String? dropdownvalue = 'ບ້ານ';
  Position? position;
  @override
  void initState() {
    super.initState();

    findLatLng();
  }

  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        // Permission denied
      }
      return null;
    }
  }

  // _openOnGoogleMapApp(double latitude, double longitude) async {
  //   String googleUrl =
  //       'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
  //   if (await canLaunch(googleUrl)) {
  //     await launch(googleUrl);
  //   } else {
  //     // Could not open the map.
  //   }
  // }

  // Future _createMarkerImageFromAsset(BuildContext context) async {
  //   if (_markerIcon == null) {
  //     ImageConfiguration configuration = ImageConfiguration();
  //     BitmapDescriptor bmpd = await BitmapDescriptor.fromAssetImage(
  //         configuration, 'assets/images/ic_airport.png');
  //     setState(() {
  //       _markerIcon = bmpd;
  //     });
  //   }
  // }

  Future<Null> determinePosition() async {
    try {
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Service Location Open');
        permission = await Geolocator.checkPermission();

        ///
        if (permission == LocationPermission.denied) {
          permission == await Geolocator.requestPermission();
          if (permission == LocationPermission.deniedForever) {
            alertLocation(context, 'ໂປຣແຊຣ໋ Location');
          } else {
            ///Find Lan Lng
            findLatLng();
          }
        } else {
          if (permission == LocationPermission.deniedForever) {
            alertLocation(context, 'ໂປຣແຊຣ໋ Location');
          } else {
            ///Find Lan Lng
            findLatLng();
          }
        }
      } else {
        print('Service Location Close');
        // alertLocation(context, 'ກາລຸນາເປີດ Location Service');
      }
    } catch (e) {
      alertLocation(context, 'ກາລຸນາເປີດ Location Service');
    }
  }

  void alertLocation(BuildContext context, String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ຂໍ້ຄວາມ !'),
            content: Text(content),
            actions: [
              // ignore: deprecated_member_use
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await Geolocator.openLocationSettings();
                  },
                  child: Text('Ok'))
            ],
          );
        });
  }

  Set<Marker> myMarKer() {
    return <Marker>[
      Marker(
        markerId: MarkerId('MarkerId'),
        position: LatLng(lat!, lng!),
        //icon: _markerIcon!,
        infoWindow:
            InfoWindow(title: 'This is a Title', snippet: 'this is a snippet'),
      ),
    ].toSet();
  }

  Future<Null> findLatLng() async {
    await getCurrentLocation();
    Position? position = await findPosition();
    setState(() {
      lat = position!.latitude;
      lng = position.longitude;
      print('lat=======> $lat,lng ========>$lng');
    });
  }

  Future<Position?> findPosition() async {
    Position position;
    try {
      position = await Geolocator.getCurrentPosition();
      return position;
    } catch (e) {
      return null;
    }
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text('ເພີ່ມທີ່ຢູ່ຈັດສົ່ງ'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10.0),
        child: InkWell(
          onTap: () {
            if (formKey.currentState!.validate()) {
              locationController.addLocation(
                address: address.text,
                type: dropdownvalue.toString(),
                day: day.text,
                time: time.text,
                lat: lat!,
                lng: lng!,
                userId: FirebaseAuth.instance.currentUser!.uid,
              );
            }
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
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  "ສະຖານທີ່ຈັດສົ່ງ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: address,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
                  maxLines: 3,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "ບ້ານ ເມືອງ ແຂວງ";
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
                    hintText: "ບ້ານ ເມືອງ ແຂວງ",
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "ວັນທີ່ຈັດສົ່ງ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: day,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
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
                  "ເວລາຈັດສົ່ງ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                TextFormField(
                  controller: time,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  keyboardType: TextInputType.text,
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
                SizedBox(height: 10),
                Text(
                  "ປະເພດສະຖານທີ່ຈັດສົ່ງ",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 5),
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey)),
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: DropdownButton<String>(
                        value: dropdownvalue,
                        isExpanded: true,
                        underline: SizedBox(),
                        onChanged: (Object? value) {
                          setState(() {
                            dropdownvalue = value as String;
                          });
                        },
                        items: item.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                      )),
                ),
                SizedBox(height: 10),
                lat == null
                    ? Center(child: CircularProgressIndicator())
                    : buildMap()
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildMap() {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.purple,
      ),
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(lat!, lng!),
          zoom: 14.0,
        ),
        zoomControlsEnabled: false,
        onMapCreated: (controller) {},
        markers: myMarKer(),
      ),
    );
  }
}
