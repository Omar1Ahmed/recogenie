import 'package:recogenie/core/error/result.dart';

abstract class AuthRepository {
  Future<Result> login(String email, String password);
  Future<Result> register({required String email, required String password, required String username});
  Future<Result> logout();
}