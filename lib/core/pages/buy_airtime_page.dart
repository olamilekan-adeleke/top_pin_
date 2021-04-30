import 'package:flutter/material.dart';
import 'package:top_pin_/core/widget/buy_airtime_widget.dart';

class AirtimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy Airtime',
        ),
        centerTitle: true,
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BuyAirtimeBody(size: size);
  }
}
