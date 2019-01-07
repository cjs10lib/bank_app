import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:uuid/uuid.dart';

class OfferImageService {
  final _storage = FirebaseStorage.instance;

  Future<String> saveOfferImage(File offerImage) async {
    final String id = Uuid().v1();
    final String fileName = '$id.jpg';

    final StorageReference ref = _storage.ref().child(fileName);

    final StorageUploadTask uploadTask = ref.putFile(
      offerImage,
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
