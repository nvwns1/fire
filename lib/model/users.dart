

import 'dart:io';

class Users{
  late String id;
  late String email;
  late String userName;
  late String imageUrl;


  Users({
    required this.id,
    required this.email,
    required this.userName,
    required this.imageUrl,
});


  factory Users.fromJson(Map<String, dynamic> json){
    return Users(
        id: json['id'],
        email: json['email'],
        userName: json['userName'],
        imageUrl: json['imageUrl']
    );
  }

}