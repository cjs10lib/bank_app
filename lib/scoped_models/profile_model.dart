import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin ProfileModel implements GeneralModel {
  Profile get accountProfile => profile;

  Future<void> fetchProfile() async {
    try {
      DocumentSnapshot doc =
          await profileService.fetchProfile(authenticatedUser.uid);
      final profileData = doc.data;

      if (doc.exists) {
        profile = Profile(
            uid: authenticatedUser.uid,
            firstname: profileData['firstname'],
            lastname: profileData['lastname'],
            mobilePhone: profileData['mobilePhone'],
            otherPhone: profileData['otherPhone'],
            email: authenticatedUser.email);
        notifyListeners();

        print('${doc.data} fetch product');
      }
    } catch (error) {
      print(error.message);
    }
  }

  Future<Map<String, dynamic>> createProfile(String firstname, String lastname,
      String mobilePhone, String otherPhone) async {
    try {
      isLoading = true;
      notifyListeners();

      await profileService.createProfile(
          authenticatedUser.uid, firstname, lastname, mobilePhone, otherPhone);

      profile = Profile(
          uid: authenticatedUser.uid,
          firstname: firstname,
          lastname: lastname,
          mobilePhone: mobilePhone,
          otherPhone: otherPhone,
          email: authenticatedUser.email);

      isLoading = false;
      notifyListeners();

      return {'success': true, 'message': 'Profile successfully created'};
    } catch (error) {
      isLoading = false;
      notifyListeners();
      return {'success': false, 'message': error.message};
    }
  }
}
