import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:bank_app/services/messaging_service.dart';
import 'package:bank_app/scoped_models/general_model.dart';

mixin MessagingModel implements GeneralModel {
  final _messagingService = MessagingService();
  final FirebaseMessaging _messaging = FirebaseMessaging();

  String get messageToken => messagingToken;

  createToken() async {
    try {
      messagingToken = await _messaging.getToken();
      
      if (messagingToken.isNotEmpty) {
        await _messagingService.createDeviceToken(
            authenticatedUser.uid, profile.firstname, profile.lastname, messagingToken);
      }
    } catch (error) {
      print(error);
    }
  }
}
