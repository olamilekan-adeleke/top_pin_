part of 'user_details_bloc.dart';

abstract class UserDetailsState extends Equatable {
  const UserDetailsState();
}

class InitialUserDetailsState extends UserDetailsState {
  @override
  List<Object> get props => [];
}

class LoadingUserDetailsState extends UserDetailsState {
  @override
  List<Object> get props => [];
}

class LoadedUserDetailsState extends UserDetailsState {
  final UserDetailsModel userDetails;

  LoadedUserDetailsState(this.userDetails);
  @override
  List<Object> get props => [];
}

class ErrorUserDetailsState extends UserDetailsState {
  final String message;

  ErrorUserDetailsState(this.message);
  @override
  List<Object> get props => [];
}
