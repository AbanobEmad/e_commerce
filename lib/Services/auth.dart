import 'package:firebase_auth/firebase_auth.dart';
class Auth{
  final _auth=FirebaseAuth.instance;
  Future<UserCredential> SignUP(String Email,String Password)async
  {
    final userCredential = await _auth.createUserWithEmailAndPassword(email: Email, password: Password);
  }
  Future<UserCredential> SignIn(String Email,String Password)async
  {
    final userCredential = await _auth.signInWithEmailAndPassword(email: Email, password: Password);
  }
  Future<void> SignOut ()async
  {
    await _auth.signOut();
  }
}