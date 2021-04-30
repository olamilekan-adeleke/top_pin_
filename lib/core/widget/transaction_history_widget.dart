

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_pin_/core/model/user_history_model.dart';

class HistoryBody extends StatelessWidget {
  final Size size;
  final List<UserHistoryModel> historys;

  const HistoryBody({Key key, this.size, this.historys}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: 20,
        separatorBuilder: (_, index) => Divider(),
        itemBuilder: (context, index) {
          return historyItem(historys[index]);
        },
      ),
    );
  }

  Widget historyItem(UserHistoryModel history) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          historyItemTitle(history),
          historyItemInfo(history),
        ],
      ),
    );
  }

  Widget historyItemTitle(UserHistoryModel history) {
    return Container(
      width: size.width * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            history.type,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            history.transaction,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w300,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget historyItemInfo(UserHistoryModel history) {
    return Container(
      width: size.width * 0.40,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            history.date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[500],
            ),
          ),
          SizedBox(height: 5.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                history.amount,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 5.0),
              Text(
                'NGN',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
