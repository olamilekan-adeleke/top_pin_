part of 'user_details_bloc.dart';

abstract class UserDetailsEvent extends Equatable {
  const UserDetailsEvent();
}

class GetUserDetailsEvent extends UserDetailsEvent {
  final String email;

  GetUserDetailsEvent(this.email);
  @override
  List<Object> get props => [];
}
