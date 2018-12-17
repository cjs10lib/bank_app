import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:bank_app/services/profile_image_service.dart';

import 'package:bank_app/scoped_models/general_model.dart';

mixin ProfileImageModel implements GeneralModel {
  File _profileImage;

  final profileImageService = ProfileImageService();

  File get profileImage => _profileImage;

  selectProfileImage(File image) {
    _profileImage = image;
  }

  Future<Map<String, dynamic>> uploadProfileImage() async {
    try {
      isLoading = true;
      notifyListeners();

      Map<String, dynamic> downloadUrl = await profileImageService
          .saveProfileImage(authenticatedUser.uid, _profileImage);

      isLoading = false;
      notifyListeners();
      print('Upload Completed and successful $downloadUrl');
      return {'success': true, 'downloadUrl': downloadUrl};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print('Upload Completed and unsuccessful ${error.message}');
      return {'success': false, 'downloadUrl': error.message};
    }
  }
}
