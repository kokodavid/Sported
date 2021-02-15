import 'dart:io';

import 'package:sported_app/locator.dart';
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/services/auth.dart';
import 'package:sported_app/services/storage_repo.dart';

class UserController {
  UserModel _currentUser;
  AuthMethods _authRepo = locator.get<AuthMethods>();
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


}
