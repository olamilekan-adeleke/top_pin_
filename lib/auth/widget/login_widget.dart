import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:top_pin_/hive_methods/hive_class.dart';

import '../../auth/constant.dart';
import '../../auth/methods/auth_methods.dart';
import '../../auth/model/login_user_model.dart';
import '../../auth/page/forgot_pasword_page.dart';
import '../../core/pages/home_page.dart';

class LoginInHeader extends StatelessWidget {
  final Size size;

  const LoginInHeader({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: size.height * 0.07),
      width: size.width,
      height: size.height * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome',
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          Text(
            'Back',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class LoginBody extends StatefulWidget {
  final Size size;
  final Function toggleView;

  const LoginBody({this.size, this.toggleView});

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();
  LoginUserModel loginUser;

  Future<void> validateForm() async {
    final formState = formKey.currentState;

    if (formState.validate()) {
      print('pass');

      loginUser = LoginUserModel(
        login: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      valueNotifier.value = true;

      try {
        Map data = await Authentication().logInUser(loginUser);
        await HiveMethods().saveUserDetails(loginUser.login);

        if (data['status'] == 1) {
          Fluttertoast.showToast(
            msg: data['message'],
            backgroundColor: Colors.green,
            textColor: Colors.white,
            fontSize: 16,
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else if (data['status'] == 0) {
          _showDialog(data['message']);
        }
      } catch (e, s) {
        print(e);
        print(s);
        _showDialog(e.toString());
      }

      valueNotifier.value = false;
    }
  }

  void _showDialog(String body) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(child: Text('Message')),
          content: Text(
            '$body',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
      width: widget.size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: form(context),
    );
  }

  Widget form(BuildContext context) {
    return Container(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sign In',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: widget.size.height * 0.05),
            emailInputFieldBox(emailController),
            SizedBox(height: widget.size.height * 0.03),
            passwordInputFieldBox(passwordController),
            SizedBox(height: widget.size.height * 0.025),
            logInButton(),
            SizedBox(height: widget.size.height * 0.06),
            moreOptions(),
            SizedBox(height: widget.size.height * 0.12),
          ],
        ),
      ),
    );
  }

  Widget logInButton() {
    return ValueListenableBuilder<bool>(
      valueListenable: valueNotifier,
      builder: (context, bool value, child) {
        print(value);
        if (value == true) {
          return Center(child: CircularProgressIndicator());
        }

        return InkWell(
          onTap: () => validateForm(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Center(
              child: Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget moreOptions() {
    return Container(
      width: widget.size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ForgetPasswordPage(),
                  ),
                );
              },
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () => widget.toggleView(),
              child: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
