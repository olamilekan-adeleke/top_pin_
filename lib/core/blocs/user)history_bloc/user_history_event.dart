part of 'user_history_bloc.dart';

abstract class UserHistoryEvent extends Equatable {
  const UserHistoryEvent();
}

class GetUserHistoryEvent extends UserHistoryEvent {
  @override
  List<Object> get props => [];
}
