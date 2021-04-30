import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:top_pin_/core/model/user_history_model.dart';
import 'package:top_pin_/hive_methods/hive_class.dart';

class GetUserHistoryRepo {
  Dio _dio = Dio();
  static final String baseUrl =
      'https://fostesting.000webhostapp.com/tiopin/api/v1';

  Future<List<UserHistoryModel>> getUserHistory() async {
    List<UserHistoryModel> history = [];

    final String userEmail = await HiveMethods().userEmail();

    FormData formData = FormData.fromMap({'Login': userEmail});

    Response response = await _dio
        .post(
          '$baseUrl/info_fetch.php',
          data: formData,
        )
        .timeout(Duration(seconds: 15));

    Map data = json.decode(response.data);

    List rawStringList = data['data'];

    if (rawStringList != null) {
      history = rawStringList.map((e) => UserHistoryModel.fromMap(e)).toList();
    }

    return history;
  }
}
