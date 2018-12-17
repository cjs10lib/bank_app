import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:bank_app/scoped_models/general_model.dart';

mixin ProfileImageModel implements GeneralModel {
  File _profileImage;

  File get profileImage => _profileImage;

  selectProfileImage(File image) {
    _profileImage = image;
  }

  Future<Map<String, dynamic>> uploadProfileImage() async {
    try {
      isLoading = true;
      notifyListeners();

      final String fileName = '${authenticatedUser.uid}.jpg';
      final StorageReference ref =
          FirebaseStorage.instance.ref().child(fileName);
      final StorageUploadTask uploadTask = ref.putFile(
        profileImage,
        StorageMetadata(
          contentLanguage: 'en',
          customMetadata: <String, String>{'activity': 'Bank-App'},
        ),
      );
      final String downloadUrl =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      isLoading = false;
      notifyListeners();
      print('Upload Completed and successful');
      return {'success': true, 'downloadUrl': downloadUrl};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print('Upload Completed and unsuccessful ${error.message}');
      return {'success': false, 'downloadUrl': error.message};
    }
  }
}
