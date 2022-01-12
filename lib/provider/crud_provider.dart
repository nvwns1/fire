import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fire/model/post.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dataProvider = StreamProvider((ref) => FireCrud().getData());
final crudProvider = Provider((ref) => FireCrud());

class FireCrud {
  final _db = FirebaseFirestore.instance.collection('posts');

  Stream<List<Post>> getData() {
    final data = _db.snapshots().map(
        (event) => event.docs.map((e) => Post.fromJson(e.data())).toList());

    return data;
  }

  Future<String> createPost({required Post post, required File image}) async {
    try {
      final imageId = DateTime.now().toIso8601String();
      final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
      await ref.putFile(image);
      final url = await ref.getDownloadURL();

      await _db.add({
        'comment': [
          {}
        ],
        'description': post.description,
        'userId': post.userId,
        'title': post.title,
        'likes': post.likes,
        'imageUrl': url
      });
      return 'success';
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<String> updatePost(
      {required String id, required Post post, required File image}) async {
    try {
      await _db.doc(id).update({
        'description': post.description,
        'title': post.title,
        'imageUrl': post.imageUrl
      });
      return 'success';
    } on FirebaseException catch (e) {
      throw e;
    }
  }

  Future<String> removePost(
      {required String id}) async {
    try {
      await _db.doc(id).delete();
      return 'success';
    } on FirebaseException catch (e) {
      throw e;
    }
  }


  Future<String> likePost(
      {required String id, required int like}) async {
    try {
      await _db.doc(id).update({
        'likes' : like + 1
      });
      return 'success';
    } on FirebaseException catch (e) {
      throw e;
    }
  }
}
