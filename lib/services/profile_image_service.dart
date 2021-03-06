import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ProfileImageService {
  final _storage = FirebaseStorage.instance;

  Future<String> fetchProfileImage(String uid) async {
    String downloadUrl;

    final String fileName = '$uid.jpg';
    final StorageReference ref = _storage.ref().child(fileName);

    downloadUrl = await ref.getDownloadURL();
    print('$downloadUrl generTED url');
    return downloadUrl;
  }

  Future<String> saveProfileImage(String uid, File profileImage) async {
    final String fileName = '$uid.jpg';

    final StorageReference ref = _storage.ref().child(fileName);

    final StorageUploadTask uploadTask = ref.putFile(
      profileImage,
      StorageMetadata(
        contentLanguage: 'en',
        customMetadata: <String, String>{'activity': 'Bank-App'},
      ),
    );
    final String downloadUrl =
        await (await uploadTask.onComplete).ref.getDownloadURL();

    return downloadUrl;
  }
}
