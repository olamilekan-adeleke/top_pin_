import 'package:flutter/material.dart';
import 'package:top_pin_/core/widget/buy_cards_widget.dart';

class CardsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy Cards Pins',
        ),
        centerTitle: true,
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BuyCardBody(size: size);
  }
}
