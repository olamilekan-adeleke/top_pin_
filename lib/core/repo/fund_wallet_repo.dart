import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:top_pin_/auth/model/user_model.dart';
import 'package:top_pin_/hive_methods/hive_class.dart';

class FundWallet {
  String _getReference() {
    String platform;
    if (Platform.isIOS) {
      platform = 'iOS';
    } else {
      platform = 'Android';
    }

    return 'ChargedFrom${platform}_${DateTime.now().microsecondsSinceEpoch}';
  }

  Future<String> createAccessCode(skTest, _getReference) async {
    // skTest -> Secret key
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $skTest'
    };

    Map data = {
      "amount": 600,
      "email": "johnsonoye34@gmail.com",
      "reference": _getReference
    };

    String payload = json.encode(data);
    http.Response response = await http.post(
      'https://api.paystack.co/transaction/initialize',
      headers: headers,
      body: payload,
    );

    final Map _data = jsonDecode(response.body);
    String accessCode = _data['data']['access_code'];

    return accessCode;
  }

  Future<void> _verifyOnServer(String reference,
      {@required BuildContext context}) async {
    String skTest = secretKey;

    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $skTest',
      };

      http.Response response = await http.get(
        'https://api.paystack.co/transaction/verify/' + reference,
        headers: headers,
      );

      final Map body = json.decode(response.body);

      if (body['data']['status'] == 'success') {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment sucessfull'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        Scaffold.of(context).showSnackBar(
          SnackBar(
            content: Text('Error Occured'),
          ),
        );
      }
    } catch (e) {
      print(e);
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Err: $e')));
    }
  }

  Future chargeCard({
    @required int price,
    @required BuildContext context,
  }) async {
    UserModel userData = await HiveMethods().getUserDetails();

    Charge charge = Charge()
      ..amount = (price * 100).toInt()
      ..reference = _getReference()
      ..email = userData.email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.card,
      charge: charge,
    );
    if (response.status == true) {
      await _verifyOnServer(response.reference, context: context);
      updateWallet(price);
    } else {
      print('error');
    }
  }

  Future bankTransfer({
    @required int price,
    @required BuildContext context,
  }) async {
    UserModel userData = await HiveMethods().getUserDetails();

    Charge charge = Charge()
      ..amount = (price * 100).toInt()
      ..reference = _getReference()
      ..accessCode = await createAccessCode(secretKey, _getReference())
      ..email = userData.email;
    CheckoutResponse response = await PaystackPlugin.checkout(
      context,
      method: CheckoutMethod.bank,
      charge: charge,
    );
    if (response.status == true) {
      await _verifyOnServer(response.reference, context: context);
      updateWallet(price);
    } else {
      print('error');
    }
  }

  Future<void> updateWallet(int amount) async {}
}

final String publicKey = 'pk_test_783f909da670ff1ad0ec676ef617ead054d113e8';
final String secretKey = 'sk_test_33dfdc0d792c01298c04c42bbc2dcabba2bf8913';
final moneyFormatter = new NumberFormat("#,##0.00", "en_US");
