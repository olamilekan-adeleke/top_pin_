import 'package:flutter/material.dart';

class UserHistoryModel {
  final String transaction;
  final String type;
  final String details;
  final String amount;
  final String status;
  final String trans_id;
  final String date;

  const UserHistoryModel({
    @required this.transaction,
    @required this.type,
    @required this.details,
    @required this.amount,
    @required this.status,
    @required this.trans_id,
    @required this.date,
  });

  factory UserHistoryModel.fromMap(Map<String, dynamic> map) {
    return new UserHistoryModel(
      transaction: map['transaction'] as String,
      type: map['type'] as String,
      details: map['details'] as String,
      amount: map['amount'] as String,
      status: map['status'] as String,
      trans_id: map['trans_id'] as String,
      date: map['date'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    // ignore: unnecessary_cast
    return {
      'transaction': this.transaction,
      'type': this.type,
      'details': this.details,
      'amount': this.amount,
      'status': this.status,
      'trans_id': this.trans_id,
      'date': this.date,
    } as Map<String, dynamic>;
  }
}
