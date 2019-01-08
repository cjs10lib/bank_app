import 'dart:async';
import 'dart:io';

import 'package:bank_app/scoped_models/general_model.dart';
import 'package:bank_app/services/profile_image_service.dart';

mixin ProfileImageModel implements GeneralModel {
  
  File _tempProfileImage;

  final profileImageService = ProfileImageService();

  String get profileImage => profileImageUrl;

  selectProfileImage(File image) {
    _tempProfileImage = image;
  }

  fetchProfileImage() async {
    try {
      profileImageUrl =
          await profileImageService.fetchProfileImage(authenticatedUser.uid);

      print('Profile image url $profileImageUrl');
      return {'success': true, 'downloadUrl': profileImageUrl};
    } catch (error) {
      print('Error ${error.message}');
      return {'success': false, 'downloadUrl': error.message};
    }
  }

  Future<Map<String, dynamic>> uploadProfileImage() async {
    try {
      isLoading = true;
      notifyListeners();

      profileImageUrl = await profileImageService.saveProfileImage(
          authenticatedUser.uid, _tempProfileImage);

      isLoading = false;
      notifyListeners();
      print('Upload Completed and successful $profileImageUrl');
      return {'success': true, 'downloadUrl': profileImageUrl};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      print('Upload Completed and unsuccessful ${error.message}');
      return {'success': false, 'downloadUrl': error.message};
    }
  }
}
