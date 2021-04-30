import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_pin_/auth/page/login_page.dart';
import 'package:top_pin_/core/blocs/user_details_bloc/user_details_bloc.dart';
import 'package:top_pin_/core/model/user_details_model.dart';
import 'package:top_pin_/core/pages/airtime_to_cash.dart';
import 'package:top_pin_/core/pages/buy_airtime_page.dart';
import 'package:top_pin_/core/pages/buy_data_page.dart';
import 'package:top_pin_/core/pages/cable_sub.dart';
import 'package:top_pin_/core/pages/cards_page.dart';
import 'package:top_pin_/core/pages/fund_wallet_page.dart';
import 'package:top_pin_/core/shared_widget/custom_dialog.dart';
import 'package:top_pin_/hive_methods/hive_class.dart';

import '../../core/widget/home_page_widget.dart';
import 'jamb_correction_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void init() async {
    await Future.delayed(Duration(seconds: 1));
    BlocProvider.of<UserDetailsBloc>(context)
        .add(GetUserDetailsEvent(await HiveMethods().userEmail()));
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDetailsBloc, UserDetailsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is LoadingUserDetailsState) {
          return Container(
            color: Colors.white,
            child: const Center(
                child: CircularProgressIndicator(strokeWidth: 2.0)),
          );
        } else if (state is LoadedUserDetailsState) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'TioPin',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              centerTitle: true,
            ),
            drawer: Drawer(child: drawer(state.userDetails)),
            body: ListView(
              children: [
                Container(height: 10.0, color: Theme.of(context).primaryColor),
                HomePageWalletBalance(
                  size: MediaQuery.of(context).size,
                  wallet: state.userDetails.wallet,
                ),
                HomeCard(size: MediaQuery.of(context).size),
                HomeServiceWidget(size: MediaQuery.of(context).size),
              ],
            ),
          );
        } else if (state is ErrorUserDetailsState) {
          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: [
              SizedBox(
                child: Image.asset('asset/error.png'),
              ),
              Text(
                state.message,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          );
        }

        return Container();
      },
    );
  }

  // Widget body(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //
  //   return BlocConsumer<UserDetailsBloc, UserDetailsState>(
  //     listener: (context, state) {},
  //     builder: (context, state) {
  //       if (state is LoadingUserDetailsState) {
  //         return const Center(
  //             child: CircularProgressIndicator(strokeWidth: 2.0));
  //       } else if (state is LoadedUserDetailsState) {
  //         return ListView(
  //           children: [
  //             HomePageUserDetails(size: size, userName: state.userDetails.name),
  //             HomePageWalletBalance(
  //               size: size,
  //               wallet: state.userDetails.wallet,
  //             ),
  //             HomeCard(size: size),
  //             HomeServiceWidget(size: size),
  //           ],
  //         );
  //       } else if (state is ErrorUserDetailsState) {
  //         return ListView(
  //           padding: EdgeInsets.symmetric(horizontal: 20.0),
  //           children: [
  //             SizedBox(
  //               child: Image.asset('asset/error.png'),
  //             ),
  //             Text(
  //               state.message,
  //               style: TextStyle(
  //                 fontWeight: FontWeight.w300,
  //                 fontSize: 16,
  //                 color: Colors.grey[500],
  //               ),
  //               textAlign: TextAlign.center,
  //             ),
  //           ],
  //         );
  //       }
  //
  //       return Container();
  //     },
  //   );
  // }

  Widget drawer(UserDetailsModel userDetails) {
    return ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 30, color: Colors.grey[600]),
              ),
              SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userDetails.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    userDetails.email,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        CustomText(
          text: '  E-Wallet',
          fontWeight: FontWeight.w300,
          size: 16,
        ),
        ListTile(
          leading: Icon(Icons.attach_money_outlined),
          title: Text('Fund Wallet'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => FundWalletPage())),
        ),
        CustomText(
          text: '  Stores',
          fontWeight: FontWeight.w300,
          size: 16,
        ),
        ListTile(
          leading: Icon(Icons.phone_in_talk_outlined),
          title: Text('Buy Airtime'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AirtimePage())),
        ),
        ListTile(
          leading: Icon(Icons.book_online_outlined),
          title: Text('Buy Data'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => DataPage())),
        ),
        ListTile(
          leading: Icon(Icons.credit_card_outlined),
          title: Text('Buy Scratch Card'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CardsPage())),
        ),ListTile(
          leading: Icon(Icons.settings_input_antenna_outlined),
          title: Text('Cable payment'),
          onTap: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CableSubscriptionPage())),
        ),
        ListTile(
          leading: Icon(Icons.cached_sharp),
          title: Text('Airtime To Cash'),
          onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AirtimeToCashPage())),
        ),
        ListTile(
          leading: Icon(Icons.edit_outlined),
          title: Text('Jamb Correction'),
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => JambCorrectionDetailsPage())),
        ),
        SizedBox(height: 40.0),
        CustomText(
          text: '  Sign Out',
          fontWeight: FontWeight.w300,
          size: 16,
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app_outlined),
          title: Text('Log Out'),
          onTap: () {
            Navigator.pop(context);
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ToggleBetweenLoginAndSignUpPage()));
          },
        ),
      ],
    );
  }
}
