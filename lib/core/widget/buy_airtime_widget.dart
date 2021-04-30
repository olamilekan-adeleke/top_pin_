import 'package:flutter/material.dart';

class BuyAirtimeBody extends StatefulWidget {
  final Size size;

  BuyAirtimeBody({Key key, this.size}) : super(key: key);

  @override
  _BuyAirtimeBodyState createState() => _BuyAirtimeBodyState();
}

class _BuyAirtimeBodyState extends State<BuyAirtimeBody> {
  final ValueNotifier<String> selectedNetwork = ValueNotifier<String>('');
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate() {
    final formState = formKey.currentState;

    if (formState.validate() && selectedNetwork.value != '') {
      String network = selectedNetwork.value;
      int phoneNumber = int.parse(phoneNumberController.text.trim());
      int amount = int.parse(amountController.text.trim());

      print(network);
      print(phoneNumber);
      print(amount);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.0),
        width: widget.size.width,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Text(
                '   Select Mobile Operator',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              networkImageList(),
              SizedBox(height: 10.0),
              Text(
                '   Enter Phone Number',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textField(phoneNumberController, 'Phone Number', 10),
              SizedBox(height: 10.0),
              Text(
                '   Enter Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              textField(amountController, '0.00', 1),
              SizedBox(height: 30.0),
              button(context),
              SizedBox(height: 40.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget button(BuildContext context) {
    return InkWell(
      onTap: () => validate(),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        width: widget.size.width,
        height: 40.0,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: Center(
          child: Text(
            'Procced',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget textField(
      TextEditingController controller, String title, int minLength) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.trim().isEmpty) {
            return '$title Can\'t Be Empty';
          } else if (value.trim().length < minLength) {
            return '$title Can\'t Be Less Than 10 digits';
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
          hintText: '$title',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget networkImageList() {
    return Container(
      height: widget.size.height * 0.12,
      width: widget.size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          networkImage('mtn.png'),
          networkImage('airtel.png'),
          networkImage('glo.jpg'),
          networkImage('9mobile.png'),
        ],
      ),
    );
  }

  Widget networkImage(String name) {
    return ValueListenableBuilder(
      valueListenable: selectedNetwork,
      builder: (_, String value, child) {
        return InkWell(
          onTap: () => selectedNetwork.value = name,
          child: Container(
            color: value == name ? Colors.red : Colors.white,
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            width: 80.0,
            height: 50.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.asset('asset/$name', fit: BoxFit.fill),
            ),
          ),
        );
      },
    );
  }
}
