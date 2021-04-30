import 'package:flutter/material.dart';
import 'package:top_pin_/core/repo/fund_wallet_repo.dart';

class BuyCardBody extends StatefulWidget {
  final Size size;

  BuyCardBody({Key key, this.size}) : super(key: key);

  @override
  _BuyCardBodyState createState() => _BuyCardBodyState();
}

class _BuyCardBodyState extends State<BuyCardBody> {
  final ValueNotifier<String> selectedType = ValueNotifier<String>('');
  final TextEditingController amountController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validate() {
    final formState = formKey.currentState;

    if (formState.validate() && selectedType.value != '') {
      String network = selectedType.value;
      int price = int.parse(amountController.text.trim());

      print(network);
      print(price);
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
                '   Select Card Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              networkImageList(),
              SizedBox(height: 10.0),
              Text(
                '   Enter Amount',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              amountTextField(amountController, 'Amount', 0),
              SizedBox(height: 10.0),
              Text(
                '   Price',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              priceTextField(priceController, 'Price', 1, false),
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

  Widget amountTextField(
      TextEditingController controller, String title, int minLength,
      [bool enable = true]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: TextFormField(
        enabled: enable,
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
        onChanged: (val) {
          print(val.trim());
          print(val.trim().length);

          if (val.trim().length > 0) {
            int _amountCount = int.parse(val.trim());

            priceController.text = moneyFormatter.format(_amountCount * 500);
          } else if (val.trim().length == 0) {
            priceController.text = moneyFormatter.format(0 * 500);
          }
        },
        decoration: InputDecoration(
          hintText: '$title',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget priceTextField(
      TextEditingController controller, String title, int minLength,
      [bool enable = true]) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: TextFormField(
        enabled: enable,
        controller: controller,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value.trim().isEmpty) {
            return '$title Can\'t Be Empty';
          } else if (value.trim().length < minLength) {
            return '$title Can\'t Be Less Than 10 digits';
          } else if (value.trim() == '0.00') {
            return 'Please Input card Amount';
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
          networkImage('wace.png'),
          networkImage('neco.jpg'),
          networkImage('wace_1.png'),
          networkImage('neco_1.jpg'),
        ],
      ),
    );
  }

  Widget networkImage(String name) {
    return ValueListenableBuilder(
      valueListenable: selectedType,
      builder: (_, String value, child) {
        return InkWell(
          onTap: () => selectedType.value = name,
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
