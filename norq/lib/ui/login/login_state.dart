part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final UserModel userdata;

  LoginSuccess(this.userdata);
}

class LoginFailuer extends LoginState {
  final String error;

  LoginFailuer({required this.error});
}
