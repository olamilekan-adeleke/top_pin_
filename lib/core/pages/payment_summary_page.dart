import 'package:flutter/material.dart';
import 'package:top_pin_/core/repo/fund_wallet_repo.dart';

class PaymentSummaryPage extends StatelessWidget {
  final String paymentType;
  final int amount;

  const PaymentSummaryPage({Key key, this.paymentType, this.amount})
      : super(key: key);

  Future<void> pay(BuildContext context) async {
    if (paymentType == 'card') {
      await FundWallet().chargeCard(
        price: amount,
        context: context,
      );
    } else if (paymentType == 'bank') {
      await FundWallet().bankTransfer(
        price: amount,
        context: context,
      );
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.35,
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: Placeholder(),
            ),
            item(
              context: context,
              title: 'Transaction Type:',
              value: 'Fund wallet',
            ),
            item(
              context: context,
              title: 'Transaction Type:',
              value: 'Fund wallet',
            ),
            item(
                context: context,
                title: 'Description:',
                value: 'Fund wallet with NGN $amount with paystack'),
            item(
              context: context,
              title: 'Amount:',
              value: 'NGN $amount',
            ),
            item(
              context: context,
              title: 'Transaction Id:',
              value: 'xxxxxxxxxxxxx',
            ),
            SizedBox(height: 20.0),
            Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: FlatButton(
                color: Theme.of(context).accentColor,
                onPressed: () => pay(context),
                child: Text(
                  'Make Payment',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget item({BuildContext context, String title, String value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
