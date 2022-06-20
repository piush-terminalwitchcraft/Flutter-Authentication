import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadPic(File file, String uid) async {
    String imageURI = "";
    final reference = _storage.ref().child("profilepic/").child(uid + ".png");
    await reference.putFile(file);
    return await reference.getDownloadURL();
  }

  Future<String> uploadPicWeb(Uint8List bytes, String uid) async {
    String imageURI = "";
    final reference = _storage.ref().child("profilepic/").child(uid + ".png");
    await reference.putData(bytes);
    return await reference.getDownloadURL();
  }
}
