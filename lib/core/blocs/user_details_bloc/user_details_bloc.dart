import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_pin_/auth/methods/auth_methods.dart';
import 'package:top_pin_/core/model/user_details_model.dart';

part 'user_details_event.dart';
part 'user_details_state.dart';

class UserDetailsBloc extends Bloc<UserDetailsEvent, UserDetailsState> {
  UserDetailsBloc() : super(InitialUserDetailsState());

  @override
  Stream<UserDetailsState> mapEventToState(
    UserDetailsEvent event,
  ) async* {
    if (event is GetUserDetailsEvent) {
      try {
        yield LoadingUserDetailsState();
        Map userData = await Authentication().getUserData(event.email);
        yield LoadedUserDetailsState(UserDetailsModel.fromMap(userData));
      } catch (e) {
        yield ErrorUserDetailsState(e?.message.toString());
      }
    }
  }
}
