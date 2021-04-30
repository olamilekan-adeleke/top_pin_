import 'package:flutter/material.dart';

class CustomWarningDialog {
  static void showCustomDialog({
    BuildContext context,
    String title,
    String message,
  }) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: CustomText(
            text: message,
            size: 16.0,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w300,
          ),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: const Text('Ok'),
            ),
          ],
        );
      },
    );
  }

  static void showSnackBar({
    BuildContext context,
    String message,
    bool warning = true,
  }) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: warning ? Colors.red : Colors.green,
        duration:
        warning ? const Duration(seconds: 2) : const Duration(seconds: 1),
      ),
    );
  }
}


class CustomText extends StatelessWidget {
  const CustomText({
    @required this.text,
    this.size,
    this.color = Colors.black,
    this.fontWeight = FontWeight.normal,
    this.textAlign = TextAlign.justify,
    this.maxLine = 2,
  });

  final String text;
  final double size;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final int maxLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: fontWeight,
      ),
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
