import 'package:flutter/material.dart';

class UserDetailsModel {
  final String wallet;
  final String email;
  final String phone;
  final String name;
  final String referrerid;

  const UserDetailsModel({
    @required this.wallet,
    @required this.email,
    @required this.phone,
    @required this.name,
    @required this.referrerid,
  });

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return new UserDetailsModel(
      wallet: map['wallet'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      name: map['name'] as String,
      referrerid: map['referrerid'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'wallet': this.wallet,
      'email': this.email,
      'phone': this.phone,
      'name': this.name,
      'referrerid': this.referrerid,
    } as Map<String, dynamic>;
  }
}
