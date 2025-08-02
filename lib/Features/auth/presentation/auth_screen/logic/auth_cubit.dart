
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
import 'package:injectable/injectable.dart';
import 'package:recogenie/Features/auth/domain/repository/auth_repository.dart';
import 'package:recogenie/core/error/result.dart';

part 'auth_state.dart';

@Injectable()
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthInitial());


  bool _isLoginWidget = true;
  bool get isLoginWidget => _isLoginWidget;


  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController nameController = TextEditingController();


  void changeLoginAndSignUp() {
    if (_isLoginWidget) {
      emit(AuthSignUpState());
    } else {
      emit(AuthSignInState());
    }
    _isLoginWidget = !_isLoginWidget;
  }


  Future<void> login() async {


    emit(AuthLoading());

      final result = await _authRepository.login(
        emailController.text,
        passwordController.text,
      );

    if(result is Success){

      emit(AuthSuccess());
    }else{
      emit(AuthError((result as FailureResult).failure.message));
    }


  }



  Future<void> signUp() async {

    emit(AuthLoading());

    final result = await _authRepository.register(
      email: emailController.text,
      password: passwordController.text,
      username: nameController.text,
    );

    if(result is Success){

      emit(AuthSuccess());
    }else{
      emit(AuthError((result as FailureResult).failure.message));
    }


  }
}

