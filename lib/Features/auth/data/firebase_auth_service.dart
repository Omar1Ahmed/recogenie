
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FireBaseAuthService {
  final FirebaseAuth _auth;
  FireBaseAuthService(this._auth);

  Future<UserCredential> signIn({required String email, required String password}) async {
    final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signUp({required String email, required String password,required String username }) async {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user!.updateDisplayName(username);
    await userCredential.user!.reload();


    return userCredential;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}