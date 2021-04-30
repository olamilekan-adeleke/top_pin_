import 'package:flutter/material.dart';
import '../../auth/constant.dart';
import '../../auth/methods/auth_methods.dart';
import '../../auth/model/register_user_model.dart';

class SignUpInHeader extends StatelessWidget {
  final Size size;

  const SignUpInHeader({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.0, top: size.height * 0.07),
      width: size.width,
      height: size.height * 0.22,
      child: Text(
        'Let\'s Start!',
        style: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}

class SignUpBody extends StatefulWidget {
  final Size size;
  final Function toggleView;

  const SignUpBody({this.size, this.toggleView});

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController referralController = TextEditingController();
  ValueNotifier<bool> valueNotifier = ValueNotifier<bool>(false);
  RegisterUserModel registerUser;
  final formKey = GlobalKey<FormState>();

  Future<void> validateForm() async {
    final formState = formKey.currentState;

    if (formState.validate()) {
      print('pass');

      registerUser = RegisterUserModel(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        referred: referralController.text.trim(),
        password: passwordController.text.trim(),
      );
      valueNotifier.value = true;

      try {
        Map data = await Authentication().signUpUser(registerUser);

        _showDialog(data['message']);
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
              'Sign Up',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: widget.size.height * 0.05),
            nameInputFieldBox(nameController),
            SizedBox(height: widget.size.height * 0.03),
            emailInputFieldBox(emailController),
            SizedBox(height: widget.size.height * 0.03),
            phoneInputFieldBox(phoneController),
            SizedBox(height: widget.size.height * 0.03),
            passwordInputFieldBox(passwordController),
            SizedBox(height: widget.size.height * 0.025),
            referralInputFieldBox(referralController),
            SizedBox(height: widget.size.height * 0.025),
            signUpButton(),
            SizedBox(height: widget.size.height * 0.03),
            moreOptions(),
            SizedBox(height: widget.size.height * 0.08),
          ],
        ),
      ),
    );
  }

  Widget signUpButton() {
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
                "Sign Up",
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: InkWell(
              onTap: () => widget.toggleView(),
              child: Text(
                'Already Sign Up? Login',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
