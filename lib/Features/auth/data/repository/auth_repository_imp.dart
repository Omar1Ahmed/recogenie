import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:recogenie/Features/auth/data/firebase_auth_service.dart';
import 'package:recogenie/Features/auth/domain/repository/auth_repository.dart';
import 'package:recogenie/core/error/failure.dart';
import 'package:recogenie/core/error/result.dart';

import '../../../../core/helper/Connectivity/connectivity_helper.dart';


@Injectable(as: AuthRepository)
class AuthRepositoryImp implements AuthRepository  {

  final FireBaseAuthService _firebaseAuthService;

  AuthRepositoryImp(this._firebaseAuthService);

  @override
  Future<Result> login(String email, String password) async {

  if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
  }

  try{

     final userCredential = await _firebaseAuthService.signIn(email: email, password: password);

    return Success(data: userCredential);

  }on FirebaseAuthException catch (e) {
     return FailureResult(Failure(message: e.message!, type: FailureType.unauthorized));
  }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
  }

  }

  @override
  Future<Result> logout() async {

    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{
    await _firebaseAuthService.signOut();

    return Success(data: true);

    }on FirebaseAuthException catch (e) {
    return FailureResult(Failure(message: e.message!, type: FailureType.unauthorized));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }
  }

  @override
  Future<Result> register({required String email, required String password, required String username}) async {

    if(!(await ConnectivityHelper.isConnected())){
    return FailureResult(Failure(message: 'No internet connection', type: FailureType.connection));
    }

    try{
    final userCredential = await _firebaseAuthService.signUp(email: email, password: password, username: username);

    return Success(data: userCredential);

    }on FirebaseAuthException catch (e) {
    return FailureResult(Failure(message: e.message!, type: FailureType.unauthorized));
    }catch (e) {
    return FailureResult(Failure(message: e.toString(), type: FailureType.general));
    }

  }

}