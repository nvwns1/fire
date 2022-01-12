import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';




final authProvider = StreamProvider((ref) {
  return FirebaseAuth.instance.authStateChanges();
});

final fireAuthProvider = Provider((ref) => FireAuth());

class FireAuth{

  final data = FirebaseFirestore.instance.collection('users');

  Future<String> signUp({required String email, required String password,
    required String userName, required File image}) async{
    try{
      final imageId = DateTime.now().toIso8601String();
      final ref = FirebaseStorage.instance.ref().child('userImage/$imageId');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();
      final response = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      data.add({
        'id': response.user!.uid,
        'email': email,
        'imageUrl': url,
        'userName': userName,
      });
      return 'success';
    }catch(err){
      throw err;
    }
  }



  Future<String> signIn({required String email, required String password}) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    }catch(err){
      throw err;
    }
  }


  Future<void> logOut() async{
    try{
      await FirebaseAuth.instance.signOut();
    }catch(err){
      throw err;
    }
  }



}


final imageProvider = ChangeNotifierProvider.autoDispose((ref) => ImageProvider());

class ImageProvider extends ChangeNotifier{

  File? image;

  void getImage () async{
    final ImagePicker _picker = ImagePicker();
    final selectedImage = await _picker.pickImage(source: ImageSource.gallery);
    image = File(selectedImage!.path);
    notifyListeners();
  }


}