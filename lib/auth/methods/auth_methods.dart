import 'dart:convert';

import 'package:dio/dio.dart';

import '../../auth/model/login_user_model.dart';
import '../../auth/model/register_user_model.dart';

class Authentication {
  static final String baseUrl =
      'https://fostesting.000webhostapp.com/tiopin/api/v1';
  Dio _dio = Dio();

  Future<Map> signUpUser(RegisterUserModel registerUser) async {
    Map data;

    try {
      print(registerUser.toMap());
      FormData formData = FormData.fromMap(registerUser.toMap());

      Response response = await _dio.post(
        '$baseUrl/register.php',
        data: formData,
      );

      print(response.data);
      data = json.decode(response.data);
    } on DioError catch (e, s) {
      throw Exception(e.message.toString());
    }
    return data;
  }

  Future<Map> logInUser(LoginUserModel loginUser) async {
    Map data;

    try {
      FormData formData = FormData.fromMap(loginUser.toMap());

      Response response = await _dio.post(
        '$baseUrl/login.php',
        data: formData,
      );

      data = json.decode(response.data);
    } on DioError catch (e, s) {
      throw Exception(e.message.toString());
    }
    return data;
  }

  Future<Map> getUserData(String email) async {
    Map data;

    try {
      FormData formData = FormData.fromMap({'Login': email});

      Response response = await _dio
          .post(
            '$baseUrl/info_fetch.php',
            data: formData,
          )
          .timeout(Duration(seconds: 15));

      data = json.decode(response.data);
    } on DioError catch (e, s) {
      throw Exception(e?.message.toString());
    }
    return data;
  }

  Future<Map> resetPassWord(String email) async {
    Map data;

    try {
      FormData formData = FormData.fromMap({'Email': email});

      Response response = await _dio.post(
        '$baseUrl/forgot_password.php',
        data: formData,
      );

      print(response.data);

      data = json.decode(response.data);
    } on DioError catch (e, s) {
      throw Exception(e.message.toString());
    }
    return data;
  }
}
