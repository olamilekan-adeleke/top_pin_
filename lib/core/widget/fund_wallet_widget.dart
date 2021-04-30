import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_pin_/core/pages/payment_summary_page.dart';

class FundWalletHeader extends StatelessWidget {
  final Size size;

  const FundWalletHeader({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      color: Theme.of(context).primaryColor,
      child: Center(
        child: Text(
          'Fund Wallet',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class FundWalletOptionList extends StatelessWidget {
  final Size size;

  const FundWalletOptionList({Key key, this.size}) : super(key: key);

  void snack(BuildContext context, String type) {
    String amount = '';
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Enter Amount'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.trim().isEmpty) {
                      return 'Amount Can\'t Be Empty';
                    } else if (value.trim().length < 10) {
                      return 'Amount Can\'t Be Less Than 10 digits';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) => amount = val.trim(),
                  decoration: InputDecoration(
                    hintText: '0.00',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 5.0,
                  right: 5.0,
                  top: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FlatButton(
                      color: Colors.red,
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cancel'),
                    ),
                    FlatButton(
                      color: Colors.green,
                      onPressed: () async {
                        if (amount.trim().length > 0) {
                          int _amountEnter = int.parse(amount);
                          await Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => PaymentSummaryPage(
                              amount: _amountEnter,
                              paymentType: type,
                            ),
                          ));
                          Navigator.pop(context);
                        }
                      },
                      child: Text(
                        'Proceed',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        InkWell(
          onTap: () => snack(context, 'card'),
          child:
              optionItem('Card Payment', 'Make payment using your debit card'),
        ),
        InkWell(
          onTap: () => snack(context, 'bank'),
          child: optionItem('Bank Transfer', 'Make payment with bank transfer'),
        ),
        optionItem(
            'Local Bank', 'Make payment by going to any local bank close-by'),
      ],
    );
  }

  Widget optionItem(String type, String des) {
    return Container(
      child: Card(
        elevation: 2.5,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$type',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: Colors.grey[700],
                    ),
                  ),
                  Text(
                    '$des',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
