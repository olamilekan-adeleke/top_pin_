import 'package:flutter/material.dart';
import 'package:top_pin_/core/shared_widget/custom_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class AirtimeToCashPage extends StatelessWidget {
  void launchURL(BuildContext context) async {
    const url = 'https://www.tiopin.com/user_area/airtime2cash';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      CustomWarningDialog.showSnackBar(
          context: context, message: 'Could not launch url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.25,
                child: Placeholder(),
              ),
              SizedBox(height: 20.0),
              CustomText(
                text:
                    'Airtime On Your MTN, GLO, AIRTEL, 9MOBILE Line, We got you covered We Buy With Ease. Please Read The Process below.',
                size: 16,
                fontWeight: FontWeight.w300,
                textAlign: TextAlign.center,
                maxLine: 4,
              ),
              SizedBox(height: 20.0),
              FlatButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => launchURL(context),
                child: CustomText(
                  text: 'Convert Airtime To Cash',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
