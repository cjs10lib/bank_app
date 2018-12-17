import 'package:bank_app/scoped_models/general_model.dart';

import 'package:bank_app/models/profile.dart';

mixin ProfileModel implements GeneralModel {
  Profile _profile;

  Future<Map<String, dynamic>> createProfile(String firstname, String lastname,
      String mobilePhone, String otherPhone) async {
    try {
      await profileService.createProfile(
          authenticatedUser.uid, firstname, lastname, mobilePhone, otherPhone);

      _profile = Profile(
          uid: authenticatedUser.uid,
          firstname: firstname,
          lastname: lastname,
          mobilePhone: mobilePhone,
          otherPhone: otherPhone,
          email: authenticatedUser.email);

      return {'success': true, 'message': 'Profile successfully created'};
    } catch (error) {
      return {'success': false, 'message': error.message};
    }
  }
}
