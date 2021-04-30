import 'package:flutter/cupertino.dart';

class LoginUserModel {
  String login;
  String password;

  LoginUserModel({
    @required this.login,
    @required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'Login': this.login,
      'Password': this.password,
    };
  }

  factory LoginUserModel.fromMap(Map<String, dynamic> map) {
    return new LoginUserModel(
      login: map['login'] as String,
      password: map['password'] as String,
    );
  }

}
