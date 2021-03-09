import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sported_app/data/models/ourUser.dart';
import 'package:sported_app/data/services/auth.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/models/UserProfile.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthMethods _authRepo = locator.get<AuthMethods>();
  UserModel userModel = UserModel();
  UserProfile userProfile = UserProfile();

  UserModel _currentUser;

  final userRef = FirebaseFirestore.instance.collection("users");
  final userProfileRef = FirebaseFirestore.instance.collection("userProfile");

  Stream<User> get authStateChanges => _auth.authStateChanges();

  //1
  Future<dynamic> signIn({String email, String password}) async {
    try {
      _currentUser = await _authRepo.signInWithEmailAndPassword(email, password);

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
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
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
  Future<void> addUserToDB({String uid, String username, String email}) async {
    userModel = UserModel(uid: uid, username: username, email: email);

    await userRef.doc(uid).set(userModel.toMap(userModel)).catchError((e) {
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

  Future<UserProfile> uploadProfile({
    String uid,
    String fullName,
    String email,
    String age,
    String gender,
    String clubA,
    String clubB,
    String clubC,
    String pasteUrl,
    String buddy,
    String coach,
  }) async {
    userProfile = UserProfile(
        fullName: fullName,
        age: age,
        gender: gender,
        clubA: clubA,
        clubB: clubB,
        clubC: clubC,
        pasteUrl: pasteUrl,
        buddy: buddy,
        coach: coach);

    await userProfileRef.doc(uid).set(userProfile.toMap(userProfile)).catchError((e) {
      print(e);
    });
  }
}
