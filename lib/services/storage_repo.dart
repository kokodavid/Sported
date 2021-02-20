import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:sported_app/models/ourUser.dart';
import 'package:sported_app/services/auth.dart';

import '../locator.dart';

class StorageRepo {
  firebase_storage.FirebaseStorage _storage = firebase_storage.FirebaseStorage.instanceFor(bucket: 'gs://sportedapp-6f6d2.appspot.com');
  AuthMethods _authRepo = locator.get<AuthMethods>();

  Future<String> uploadFile(File file) async {
    UserModel user = await _authRepo.getUser();
    var userId = user.uid;

    var storageRef = _storage.ref().child("user/profile/$userId");
    var uploadTask = storageRef.putFile(file);
    var imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }

  Future<String> getUserProfileImage(String uid) async {
    return await _storage.ref().child("user/profile/$uid").getDownloadURL();
  }
}
