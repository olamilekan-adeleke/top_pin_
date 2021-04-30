import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:top_pin_/core/model/buy_data_model.dart';
import 'package:top_pin_/core/model/cable_plan_list.dart';
import 'package:top_pin_/core/model/data_list_model.dart';

class ServiceRepo {
  Dio _dio = Dio();
  static final String baseUrl =
      'https://fostesting.000webhostapp.com/tiopin/api/v1';

  Future<List<DataListModel>> getDataList(String dataType) async {
    List<DataListModel> message = [];

    FormData formData = FormData.fromMap({'Data_Type': dataType});

    Response response = await _dio
        .post(
          '$baseUrl/data_price_fetch.php',
          data: formData,
        )
        .timeout(Duration(seconds: 15));

    Map data = json.decode(response.data);

    List rawStringList = data['data'];

    if (rawStringList != null) {
      message = rawStringList.map((e) => DataListModel.fromMap(e)).toList();
    }

    return message;
  }

  Future<List<CablePlanListModel>> getCablePlanList(String cableType) async {
    List<CablePlanListModel> cablePlan = [];

    Response response = await _dio
        .get('https://vtpass.com/api/service-variations?serviceID=$cableType')
        .timeout(Duration(seconds: 15));

    print(response.data);

    Map data = response.data;

    List rawStringList = data['content']['varations'];

    if (rawStringList != null) {
      cablePlan =
          rawStringList.map((e) => CablePlanListModel.fromMap(e)).toList();
    }

    return cablePlan;
  }

  Future<String> buyData(BuyDataModel buyDataModel) async {
    String message;

    FormData formData = FormData.fromMap(await buyDataModel.toMap());

    Response response = await _dio
        .post(
          '$baseUrl/data_purchase.php',
          data: formData,
        )
        .timeout(Duration(seconds: 15));

    Map data = json.decode(response.data);

    message = data['message'];

    return message;
  }
}
