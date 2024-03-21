part of 'sign_up_cubit.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final UserModel data;

  SignUpSuccess(this.data);
}

class SignUpFailure extends SignUpState {
  final String error;

  SignUpFailure(this.error);
}
