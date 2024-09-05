import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final FirebaseStorage _storage = FirebaseStorage.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImagetoStorage(Uint8List file) async {
    try {
      // Create a unique file name for each upload
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = _storage.ref().child('userProfilePictures/$fileName');

      UploadTask uploadTask = ref.putData(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();

      print('Download URL: $downloadUrl'); // Print the download URL for debugging
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<String> saveData({required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try {
      String imageUrl = await uploadImagetoStorage(file);
      await _firestore.collection('userProfile').add({
        "imageLink": imageUrl,
      });
      resp = "Success";
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
