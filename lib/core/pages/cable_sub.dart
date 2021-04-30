import 'package:flutter/material.dart';
import 'package:top_pin_/core/widget/cable_sub_widget.dart';

class CableSubscriptionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cable Subscription',
        ),
        centerTitle: true,
      ),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return CableSubBody(size: size);
  }
}
