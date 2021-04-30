import 'package:flutter/material.dart';
import 'package:top_pin_/core/widget/buy_data_widget.dart';

class DataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Buy Data',
        ),
        centerTitle: true,
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BuyDataBody(size: size);
  }
}
