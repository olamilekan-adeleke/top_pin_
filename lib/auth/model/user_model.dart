import 'package:flutter/cupertino.dart';

class UserModel {
  String wallet;
  String email;
  String name;
  String referrerid;
  String phone;

  UserModel({
    @required this.wallet,
    @required this.email,
    @required this.name,
    @required this.referrerid,
    @required this.phone,
  });

  Map<String, dynamic> toMap() {
    return {
      'wallet': this.wallet,
      'email': this.email,
      'name': this.name,
      'referrerid': this.referrerid,
      'phone': this.phone,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return new UserModel(
      wallet: map['wallet'] as String,
      email: map['email'] as String,
      name: map['name'] as String,
      referrerid: map['referrerid'] as String,
      phone: map['phone'] as String,
    );
  }
}
