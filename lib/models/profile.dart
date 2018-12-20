import 'package:flutter/material.dart';

class Profile {
  String uid;
  String firstname;
  String lastname;
  String mobilePhone;
  String otherPhone;
  String email;
  String address;

  Profile(
      {@required this.uid,
      @required this.firstname,
      @required this.lastname,
      @required this.mobilePhone,
      this.otherPhone,
      @required this.email,
      @required this.address});
}
