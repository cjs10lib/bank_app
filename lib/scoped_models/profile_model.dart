import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

mixin ProfileModel implements GeneralModel {
  Profile _profile;

  Profile get profile => _profile;

  fetchProfile() async {
    try {
      DocumentSnapshot doc =
          await profileService.fetchProfile(authenticatedUser.uid);
      final profile = doc.data;

      if (doc.exists) {
        _profile = Profile(
            uid: authenticatedUser.uid,
            firstname: profile['firstname'],
            lastname: profile['lastname'],
            mobilePhone: profile['mobilePhone'],
            otherPhone: profile['otherPhone'],
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

      _profile = Profile(
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
