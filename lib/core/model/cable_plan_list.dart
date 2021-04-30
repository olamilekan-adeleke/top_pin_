import 'package:flutter/material.dart';

class CablePlanListModel {
  final String variation_code;
  final String name;
  final String variation_amount;
  final String fixedPrice;

  const CablePlanListModel({
    this.variation_code,
    this.name,
    this.variation_amount,
    this.fixedPrice,
  });

  factory CablePlanListModel.fromMap(Map<String, dynamic> map) {
    return new CablePlanListModel(
      variation_code: map['variation_code'] as String,
      name: map['name'] as String,
      variation_amount: map['variation_amount'] as String,
      fixedPrice: map['fixedPrice'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'variation_code': this.variation_code,
      'name': this.name,
      'variation_amount': this.variation_amount,
      'fixedPrice': this.fixedPrice,
    } as Map<String, dynamic>;
  }
}
