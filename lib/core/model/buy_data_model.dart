import 'package:flutter/material.dart';
import 'package:top_pin_/hive_methods/hive_class.dart';
import 'package:uuid/uuid.dart';

class BuyDataModel {
  final String Data_Type;
  final String Data_Plan;
  final String Data_Price;
  final String Data_Reciever;
  final String TransactionId;
  final String User;

  const BuyDataModel( {
    @required this.Data_Type,
    @required this.Data_Price,
    @required this.Data_Plan,
    @required this.Data_Reciever,
    this.TransactionId,
    this.User,

  });

  factory BuyDataModel.fromMap(Map<String, dynamic> map) {
    return new BuyDataModel(
      Data_Type: map['Data_Type'] as String,
      Data_Plan: map['Data_Plan'] as String,
      Data_Price: map['Data_Price'] as String,
      Data_Reciever: map['Data_Reciever'] as String,
      TransactionId: map['TransactionId'] as String,
      User: map['User'] as String,
    );
  }

  Future<Map<String, dynamic>> toMap() async {
    // ignore: unnecessary_cast
    return {
      'Data_Type': this.Data_Type,
      'Data_Plan': this.Data_Plan,
      'Data_Price': this.Data_Price,
      'Data_Reciever': this.Data_Reciever,
      'TransactionId': Uuid().v1(),
      'User': await  HiveMethods().userEmail(),
    } as Map<String, dynamic>;
  }


}
