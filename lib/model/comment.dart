

class Comment{
   late String? comment;
   late String? userName;
   late String? userImage;

   Comment({
      this.userName,
      this.comment,
      this.userImage,

});


   factory Comment.fromJson(Map<String, dynamic> json){
     return Comment(
       userName: json['userName'],
       userImage: json['userImage'],
       comment: json['comment'],
     );
   }
}