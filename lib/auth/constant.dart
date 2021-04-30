import 'package:flutter/material.dart';

BoxDecoration _textField = BoxDecoration(
  borderRadius: BorderRadius.circular(15),
  color: Colors.green[50],
);

Widget emailInputFieldBox(TextEditingController controller) {
  return Container(
    child: TextFormField(
      controller: controller,
      validator: (value) {
        if (value.trim().isEmpty) {
          return 'Email Can\'t Be Empty';
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        labelText: "Email",
      ),
      keyboardType: TextInputType.emailAddress,
    ),
    padding: EdgeInsets.symmetric(horizontal: 15),
  );
}

Widget passwordInputFieldBox(TextEditingController controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'Password Can\'t Be Empty';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
    ),
  );
}

Widget phoneInputFieldBox(TextEditingController controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'Phone Number Can\'t Be Empty';
          } else if (value.trim().length < 10) {
            return 'Phone Number Can\'t Be Less Than 10 digits';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Phone Number',
        ),
      ),
    ),
  );
}

Widget nameInputFieldBox(TextEditingController controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'Name Can\'t Be Empty';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Name',
        ),
      ),
    ),
  );
}

Widget referralInputFieldBox(TextEditingController controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: 'Referral (Optional)',
        ),
      ),
    ),
  );
}

Widget fundInputFieldBox(TextEditingController controller) {
  return Container(
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.trim().isEmpty) {
            return 'Amount Can\'t Be Empty';
          } else if (value.trim().length < 10) {
            return 'Amount Can\'t Be Less Than 1 digits';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          labelText: 'Enter Amount',
        ),
      ),
    ),
  );
}
