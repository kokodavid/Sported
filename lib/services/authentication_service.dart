import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sported_app/models/ourUser.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserModel userModel = UserModel();
  final userRef = FirebaseFirestore.instance.collection("users");

  AuthenticationService();

  Stream<User>get authStateChanges => _auth.authStateChanges();

  //1
  Future<dynamic> signIn({String email, String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return "Logged In Successfully";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        return "Wrong password provided for that user.";
      } else {
        return "Something Went Wrong.";
      }
    }
  }

  //2
  Future<String> signUp({String email, String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "Registered Successfully";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "The password provided is too weak.";
      } else if (e.code == 'email-already-in-use') {
        return "The account already exists for that email.";
      } else {
        return "Something Went Wrong.";
      }
    } catch (e) {
      print(e);
    }
  }

  //3
  Future<void> addUserToDB(
      {String uid, String username, String email}) async {
    userModel = UserModel(
        uid: uid, username: username, email: email);

  await userRef.doc(uid).set(userModel.toMap(userModel)).catchError((e){
    print(e);
  });
  }

  //4
  Future<UserModel> getUserFromDB({String uid}) async {
    final DocumentSnapshot doc = await userRef.doc(uid).get();

    print(doc.data());

    return UserModel.fromMap(doc.data());
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }



}