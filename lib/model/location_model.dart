import 'package:cloud_firestore/cloud_firestore.dart';

class LocationModel {
  final String? id;
  final String? address;
  final String? type;
  final String? day;
  final String? time;
  final GeoPoint? location;
  final String? userId;
  LocationModel({
    this.id,
    this.address,
    this.type,
    this.day,
    this.time,
    this.location,
    this.userId,
  });
  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        id: json['id'],
        address: json['address'],
        type: json['type'],
        day: json['day'],
        time: json['time'],
        location: json['location'],
        userId: json['userId'],
      );
  Map<String, dynamic> toJson() => {
        'id': id,
        'address': address,
        'type': type,
        'day': day,
        'time': time,
        'location': location,
        'userId': userId,
      };
}
