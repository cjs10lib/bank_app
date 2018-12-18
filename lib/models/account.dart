
import 'package:flutter/material.dart';

class Account {
  String uid;
  bool isActivated;
  dynamic created;
  dynamic lastUpdate;

  Account({@required this.uid, this.isActivated = false, this.created, this.lastUpdate});
}