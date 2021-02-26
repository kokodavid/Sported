import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/models/UserProfile.dart';
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/services/authentication_service.dart';
import 'package:sported_app/services/storage_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");
  final userProfileRef = FirebaseFirestore.instance.collection("userProfile");
  UserModel userModel = UserModel();
  UserProfile userProfile = UserProfile();
  UserModel _currentUser;

  AuthMethods _authRepo = locator.get<AuthMethods>();
  AuthenticationService _authenticationService = locator.get<AuthenticationService>();
  StorageRepo _storageRepo = locator.get<StorageRepo>();

  Future init;

  UserController() {
    init = initUser();
  }

  Future<UserModel> initUser() async {
    _currentUser = await _authRepo.getUser();
    return _currentUser;
  }

  UserModel get currentUser => _currentUser;

   Future<void> uploadProfilePicture(File image)async {
    _currentUser.avatarUrl = await locator.get<StorageRepo>().uploadFile(image);
  }

  Future<String> getDownloadUrl() async {
    return await _storageRepo.getUserProfileImage(currentUser.uid);
  }

  // Future<dynamic> signInWithEmailAndPassword(
  //     {String email, String password}) async {
  //   _currentUser = await _authRepo.signInWithEmailAndPassword(email, password);
  //
  //   _currentUser.avatarUrl = await getDownloadUrl();
  //
  //
  // }

  Future<dynamic> signInWithEmailAndPassword({String email, String password}) async {
    try {
      _currentUser = await _authRepo.signInWithEmailAndPassword(
          email, password);

      _currentUser.avatarUrl = await getDownloadUrl();


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


  Future<UserModel> getUserFromDB() async {

    final DocumentSnapshot doc = await userRef.doc(currentUser.uid).get();

    print(doc.data());

    return UserModel.fromMap(doc.data());
  }

  Future<void> loginUser(
      {String email, String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(email, password);

    _currentUser.avatarUrl = await getDownloadUrl();
  }

  Future<UserProfile> uploadProfile(
      {String uid,String fullName,String email,String age,String gender,String clubA,String clubB,String clubC,String pasteUrl,String buddy,String coach,})async{
     userProfile = UserProfile(fullName: fullName,age: age,gender: gender,clubA: clubA,clubB: clubB,clubC: clubC,pasteUrl: pasteUrl,buddy: buddy,coach: coach);

     await userProfileRef.doc(_currentUser.uid).set(userProfile.toMap(userProfile)).catchError((e){
       print(e);
     });


  }





}
