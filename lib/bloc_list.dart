import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:top_pin_/core/blocs/data_bloc/data_bloc.dart';
import 'package:top_pin_/core/blocs/user)history_bloc/user_history_bloc.dart';
import 'package:top_pin_/core/blocs/user_details_bloc/user_details_bloc.dart';

import 'core/blocs/cable_sub/cable_bloc.dart';

List<BlocProvider> blocList(BuildContext context) {
  return <BlocProvider>[
    BlocProvider<UserDetailsBloc>(create: (context) => UserDetailsBloc()),
    BlocProvider<UserHistoryBloc>(create: (context) => UserHistoryBloc()),
    BlocProvider<DataBloc>(create: (context) => DataBloc()),
    BlocProvider<CableBloc>(create: (context) => CableBloc()),
  ];
}
