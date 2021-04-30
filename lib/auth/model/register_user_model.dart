import 'package:flutter/widgets.dart';

class RegisterUserModel {
  String email;
  String name;
  String referred;
  String phone;
  String password;

  RegisterUserModel({
    @required this.email,
    @required this.name,
    @required this.referred,
    @required this.phone,
    @required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'Email': this.email,
      'Name': this.name,
      'Referred': this.referred,
      'Phone': this.phone,
      'Password': this.password,
    };
  }

  factory RegisterUserModel.fromMap(Map<String, dynamic> map) {
    return new RegisterUserModel(
      email: map['email'] as String,
      name: map['name'] as String,
      referred: map['referred'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
    );
  }

}
