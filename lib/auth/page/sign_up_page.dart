import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../auth/widget/sign_up_widgets.dart';

class SignUpPage extends StatelessWidget {
  final Function toggleView;

  SignUpPage({@required this.toggleView});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SignUpInHeader(size: MediaQuery.of(context).size),
                SignUpBody(
                  size: MediaQuery.of(context).size,
                  toggleView: toggleView,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
