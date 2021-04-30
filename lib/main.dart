import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paystack/flutter_paystack.dart';
import 'package:top_pin_/bloc_list.dart';
import 'package:top_pin_/hive_methods/hive_class.dart';

import 'auth/page/login_page.dart';
import 'core/repo/fund_wallet_repo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveMethods().startUserHive();
  await PaystackPlugin.initialize(publicKey: publicKey);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocList(context),
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blueAccent,
          // accentColor: Colors.yellow,
        ),
        // home: HomePage(),
        home: ToggleBetweenLoginAndSignUpPage(),
      ),
    );
  }
}
