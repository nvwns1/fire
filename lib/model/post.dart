import 'package:fire/model/comment.dart';

class Post {
  late String? id;
  late String title;
  late String description;
  late String userId;
  late int likes = 0;
  late List<Comment>? comment;
  late String? imageUrl;

  Post({
    this.id,
    required this.title,
    required this.description,
    required this.userId,
    this.comment,
    required this.likes,
     this.imageUrl,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      comment: json['comment'],
      description: json['description'],
      id: json['id'],
      userId: json['userId'],
      title: json['title'],
      likes: json['likes'],
      imageUrl: json['imageUrl'],
    );
  }
}
