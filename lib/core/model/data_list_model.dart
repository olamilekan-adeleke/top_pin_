import 'package:flutter/material.dart';

class DataListModel{
  final String name;
  final String price;

  const DataListModel({
    @required this.name,
    @required this.price,
  });

  factory DataListModel.fromMap(Map<String, dynamic> map) {
    return new DataListModel(
      name: map['name'] as String,
      price: map['price'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'name': this.name,
      'price': this.price,
    } as Map<String, dynamic>;
  }


}