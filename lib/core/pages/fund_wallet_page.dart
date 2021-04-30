import 'package:flutter/material.dart';
import 'package:top_pin_/core/widget/fund_wallet_widget.dart';

class FundWalletPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Fund Wallet',
          ),
          centerTitle: true,
        ),
        body: body(context),
      ),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List list = [
      FundWalletOptionList(size: size),
    ];

    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) => list[index],
    );
  }
}
