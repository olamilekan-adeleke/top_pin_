import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:top_pin_/core/model/user_history_model.dart';
import 'package:top_pin_/core/repo/get_user_history.dart';

part 'user_history_event.dart';
part 'user_history_state.dart';

class UserHistoryBloc extends Bloc<UserHistoryEvent, UserHistoryState> {
  UserHistoryBloc() : super(InitialUserHistoryState());

  @override
  Stream<UserHistoryState> mapEventToState(
    UserHistoryEvent event,
  ) async* {
    if (event is GetUserHistoryEvent) {
      try {
        yield LoadingUserHistoryState();
        List<UserHistoryModel> history =
            await GetUserHistoryRepo().getUserHistory();
        yield LoadedUserHistoryState(history);
      } catch (e, s) {
        print(e);
        print(s);
        yield ErrorUserHistoryState(e?.message.toString());
      }
    }
  }
}
