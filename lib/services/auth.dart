import 'package:firebase_auth/firebase_auth.dart';
import 'package:sported_app/models/ourUser.dart';

class AuthMethods{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthMethods();


  Future<UserModel> getUser() async {
    var firebaseUser = await _auth.currentUser;
    return UserModel(uid:firebaseUser.uid);
  }

  UserModel _userFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  Future<UserModel> signInWithEmailAndPassword(String email, String password)async{
    var authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return UserModel(uid:authResult.user.uid,
        username: authResult.user.displayName);
  }

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword
        (email: email, password: password);
      User firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    }catch (e){
      print(e.toString());
    }
  }


  Future resetPassword(String email) async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);
    }catch(e){
      print(e.toString());
    }
  }

  Future signOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
    }
  }

}