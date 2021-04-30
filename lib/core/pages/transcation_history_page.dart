import 'package:flutter/material.dart';
import 'package:top_pin_/core/model/user_history_model.dart';
import 'package:top_pin_/core/widget/transaction_history_widget.dart';

class TransactionHistoryPage extends StatelessWidget {
  final List<UserHistoryModel> historys;

  const TransactionHistoryPage({Key key, this.historys}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Transactions',
        ),
        centerTitle: true,
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (historys.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              width: 300,
              child: Image.asset('asset/error.png', fit: BoxFit.fill),
            ),
          ),
          Center(
            child: Text(
              'No History Found',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
          ),
        ],
      );
    }

    return HistoryBody(size: size, historys: historys);
  }
}
