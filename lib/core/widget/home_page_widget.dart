import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_pin_/core/blocs/user)history_bloc/user_history_bloc.dart';
import 'package:top_pin_/core/model/user_history_model.dart';
import 'package:top_pin_/core/pages/airtime_to_cash.dart';
import 'package:top_pin_/core/pages/buy_airtime_page.dart';
import 'package:top_pin_/core/pages/buy_data_page.dart';
import 'package:top_pin_/core/pages/cable_sub.dart';
import 'package:top_pin_/core/pages/cards_page.dart';
import 'package:top_pin_/core/pages/fund_wallet_page.dart';
import 'package:top_pin_/core/pages/jamb_correction_page.dart';
import 'package:top_pin_/core/pages/transcation_history_page.dart';
import 'package:top_pin_/core/repo/fund_wallet_repo.dart';

// class HomePageHeader extends StatelessWidget {
//   final Size size;
//   final UserDetailsModel userDetailsModel;
//
//   const HomePageHeader({this.size, this.userDetailsModel});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Theme.of(context).primaryColor,
//       padding: EdgeInsets.symmetric(horizontal: 10.0),
//       width: size.width,
//       height: size.height * 0.12,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           HomePageUserDetails(size: size, userName: userDetailsModel.name),
//           Icon(Icons.notifications_none, color: Colors.white),
//         ],
//       ),
//     );
//   }
// }

class HomePageUserDetails extends StatelessWidget {
  final Size size;
  final String userName;

  const HomePageUserDetails({this.size, this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      height: size.height * 0.10,
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
          ),
          SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userName,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomePageWalletBalance extends StatelessWidget {
  final Size size;
  final String wallet;

  const HomePageWalletBalance({Key key, this.size, this.wallet})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      width: size.width,
      height: size.height * 0.14,
      padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Wallet Balance',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w300,
                color: Colors.white,
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ' NGN ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
                Text(
                  moneyFormatter.format(int.parse(wallet)),
                  style: TextStyle(
                    fontSize: 55,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCard extends StatefulWidget {
  final Size size;

  const HomeCard({Key key, this.size}) : super(key: key);

  @override
  _HomeCardState createState() => _HomeCardState();
}

class _HomeCardState extends State<HomeCard> {
  List userHistorys = [];

  void navigate(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionHistoryPage(historys: userHistorys),
      ),
    );
  }

  @override
  void initState() {
    BlocProvider.of<UserHistoryBloc>(context).add(GetUserHistoryEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: widget.size.width,
      child: BlocConsumer<UserHistoryBloc, UserHistoryState>(
        listener: (context, state) {
          print('state: $state');
        },
        builder: (context, state) {
          if (state is LoadedUserHistoryState) {
            userHistorys = state.userHistory;
            UserHistoryModel userHistory;

            if (userHistorys.isEmpty) {
              userHistory = UserHistoryModel(
                transaction: 'No History Found',
                type: '',
                details: '',
                amount: '',
                status: '',
                trans_id: '',
                date: '',
              );
            } else {
              userHistory = userHistorys.first;
            }

            return Container(
              height: widget.size.height * 0.12,
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Colors.white, width: 2.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () => navigate(context),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.size.width * 0.40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(userHistory.type, 20.0, FontWeight.bold),
                            text(
                                userHistory.transaction, 16.0, FontWeight.w300),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: widget.size.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                              userHistory.date,
                              16.0,
                              FontWeight.w300,
                            ),
                            text(userHistory.amount, 20.0, FontWeight.bold),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is LoadingUserHistoryState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ErrorUserHistoryState) {
            return Container(
              height: widget.size.height * 0.12,
              margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                border: Border.all(color: Colors.white, width: 2.5),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: InkWell(
                onTap: () => navigate(context),
                child: Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: widget.size.width * 0.40,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text('', 20.0, FontWeight.bold),
                            text('', 16.0, FontWeight.w300),
                          ],
                        ),
                      ),
                      Spacer(),
                      Container(
                        width: widget.size.width * 0.35,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            text(
                              '',
                              16.0,
                              FontWeight.w300,
                            ),
                            text('', 20.0, FontWeight.bold),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        child:
                            Icon(Icons.arrow_forward_ios, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget text(String message, double size, FontWeight fontWeight) {
    return Text(
      '$message',
      style: TextStyle(
        color: Colors.white,
        fontSize: size,
        fontWeight: fontWeight,
      ),
    );
  }
}

// class HomePageProductWidget extends StatelessWidget {
//   final Size size;
//
//   const HomePageProductWidget({Key key, this.size}) : super(key: key);
//
//   void navigate(BuildContext context, Widget page) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => page,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
//       width: size.width,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               InkWell(
//                 onTap: () => navigate(context, FundWalletPage()),
//                 child: iconsWidget('asset/cash_icon.png', 'Fund Wallet'),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               InkWell(
//                 onTap: () => navigate(context, AirtimePage()),
//                 child: iconsWidget('asset/cash_icon.png', 'Buy Airtime'),
//               ),
//               InkWell(
//                 onTap: () => navigate(context, DataPage()),
//                 child: iconsWidget('asset/cash_icon.png', 'Buy Data'),
//               ),
//               InkWell(
//                 onTap: () => navigate(context, CardsPage()),
//                 child: iconsWidget('asset/cash_icon.png', 'Buy Card Pin'),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               iconsWidget('asset/cash_icon.png', 'Transcation History'),
//               iconsWidget('asset/cash_icon.png', 'Wace Card'),
//               iconsWidget('asset/cash_icon.png', 'Neco Card'),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget iconsWidget(
//     String imageUrl,
//     String title,
//   ) {
//     return Container(
//       height: size.height * 0.17,
//       width: size.width * 0.31,
//       child: Card(
//         child: Column(
//           children: [
//             Container(
//               color: Colors.white,
//               child: Image.asset(
//                 imageUrl,
//                 fit: BoxFit.fill,
//                 height: size.height * 0.10,
//                 width: size.width * 0.2,
//               ),
//             ),
//             Text(
//               '$title',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.w300,
//               ),
//               textAlign: TextAlign.center,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeServiceWidget extends StatelessWidget {
  final Size size;

  const HomeServiceWidget({Key key, this.size}) : super(key: key);

  void navigate(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      width: size.width,
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: [
          SizedBox(height: 10.0),
          InkWell(
            onTap: () => navigate(context, FundWalletPage()),
            child: item(
              imageName: 'asset/fund_wallet.png',
              title: 'Fund Wallet',
              width: size.width * 0.40,
              height: size.height * 0.10,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => navigate(context, AirtimePage()),
                child: item(
                  imageName: 'asset/buy_airtime.png',
                  title: 'Buy Airtime',
                  width: size.width * 0.44,
                  height: size.height * 0.18,
                ),
              ),
              InkWell(
                onTap: () => navigate(context, DataPage()),
                child: item(
                  imageName: 'asset/buy_data.png',
                  title: 'Buy Data',
                  width: size.width * 0.44,
                  height: size.height * 0.18,
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () => navigate(context, CardsPage()),
                child: item(
                  imageName: 'asset/card.png',
                  title: 'Buy Card Pins',
                  width: size.width * 0.44,
                  height: size.height * 0.18,
                ),
              ),
              InkWell(
                onTap: () => navigate(context, JambCorrectionDetailsPage()),
                child: item(
                  imageName: 'asset/card.png',
                  title: 'Jamb Details Correction',
                  width: size.width * 0.44,
                  height: size.height * 0.18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              InkWell(
                onTap: () => navigate(context, AirtimeToCashPage()),
                child: item(
                  imageName: 'asset/card.png',
                  title: 'Airtime To cash',
                  width: size.width * 0.44,
                  height: size.height * 0.10,
                ),
              ),
              InkWell(
                onTap: () => navigate(context, CableSubscriptionPage()),
                child: item(
                  imageName: 'asset/card.png',
                  title: 'Cable Subscription',
                  width: size.width * 0.44,
                  height: size.height * 0.10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget item({
    String imageName,
    String title,
    double width,
    double height,
  }) {
    return Card(
      elevation: 3.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            width: width,
            height: height,
            child: Image.asset(imageName),
          ),
          Text(
            '$title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
