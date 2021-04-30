part of 'user_history_bloc.dart';

abstract class UserHistoryState extends Equatable {
  const UserHistoryState();
}

class InitialUserHistoryState extends UserHistoryState {
  @override
  List<Object> get props => [];
}

class LoadingUserHistoryState extends UserHistoryState {
  @override
  List<Object> get props => [];
}

class LoadedUserHistoryState extends UserHistoryState {
  final List<UserHistoryModel> userHistory;

  LoadedUserHistoryState(this.userHistory);
  @override
  List<Object> get props => [];
}

class ErrorUserHistoryState extends UserHistoryState {
  final String message;

  ErrorUserHistoryState(this.message);
  @override
  List<Object> get props => [];
}
