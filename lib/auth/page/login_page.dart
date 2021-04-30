import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../auth/page/sign_up_page.dart';
import '../../auth/widget/login_widget.dart';

class ToggleBetweenLoginAndSignUpPage extends StatefulWidget {
  @override
  _ToggleBetweenLoginAndSignUpPageState createState() =>
      _ToggleBetweenLoginAndSignUpPageState();
}

class _ToggleBetweenLoginAndSignUpPageState
    extends State<ToggleBetweenLoginAndSignUpPage> {
  bool showLogInPage = true;

  void toggleView() {
    setState(() {
      showLogInPage = !showLogInPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogInPage) {
      return LogInPage(toggleView: toggleView);
    } else {
      return SignUpPage(toggleView: toggleView);
    }
  }
}

class LogInPage extends StatelessWidget {
  final Function toggleView;

  LogInPage({this.toggleView});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LoginInHeader(size: MediaQuery.of(context).size),
                LoginBody(
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
