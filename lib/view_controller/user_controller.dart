import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sported_app/locator.dart';
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/services/authentication_service.dart';
import 'package:sported_app/services/storage_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserController {
  FirebaseAuth auth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");
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

  Future<void> signInWithEmailAndPassword(
      {String email, String password}) async {
    _currentUser = await _authRepo.signInWithEmailAndPassword(email, password);

    _currentUser.avatarUrl = await getDownloadUrl();
  }

  Future<UserModel> getUserFromDB() async {

    final DocumentSnapshot doc = await userRef.doc(currentUser.uid).get();

    print(doc.data());

    return UserModel.fromMap(doc.data());
  }

  // Future<void> loginUser(
  //     {String email, String password}) async {
  //   _currentUser = await _authRepo.signInWithEmailAndPassword(email, password);
  //
  //   _currentUser.avatarUrl = await getDownloadUrl();
  // }






}
