import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:norq/data/models/user_model.dart';
import 'package:norq/data/repositories/user_repository.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final UserRespository _respository;
  SignUpCubit(this._respository) : super(SignUpInitial());
  void registerUser(
      String name, String email, String address, String password) async {
    emit(SignUpLoading());
    try {
      UserCredential userData =
          await _respository.registerUser(email, password);
      UserModel userdata = UserModel(
          userID: userData.user!.uid,
          name: name,
          email: email,
          address: address);
      var data = await _respository
          .addUser(userdata)
          .then((value) => emit(SignUpSuccess(userdata)))
          .catchError((e) => emit(SignUpFailure("Something went wrong")));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
