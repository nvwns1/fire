import 'dart:io';

import 'package:fire/model/comment.dart';
import 'package:fire/model/post.dart';
import 'package:fire/provider/auth_provider.dart';
import 'package:fire/provider/crud_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostAddScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final _form = GlobalKey<FormState>();
  final id = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Card(
            child: Padding(
              padding:
              const EdgeInsets.symmetric( horizontal: 20.0),
              child: Consumer(
                  builder: (context, ref, child) {
                    final image = ref.watch(imageProvider).image;
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text('Create Post',
                            style: TextStyle(
                                fontSize: 40
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: titleController,
                            validator: (val){
                              if(val!.isEmpty){
                                return 'Please provide title';
                              }
                              else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(label: Text('Title')),
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: desController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val){
                              if(val!.isEmpty){
                                return 'Please provide description';
                              }else{
                                return null;
                              }
                            },
                            decoration: InputDecoration(label: Text('Description')),
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          InkWell(
                            onTap: (){
                              ref.read(imageProvider).getImage();
                            },
                            child: Container(
                                width: double.infinity,
                                height: 100,
                                child: image == null ? Center(child:
                                Text('Please select Image')):
                                Image.file(File(image.path), fit: BoxFit.cover,)
                            ),
                          ),

                          SizedBox(height: 20,),

                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(onPressed: () async{

                            _form.currentState!.save();
                            if(_form.currentState!.validate()){
                              FocusScope.of(context).unfocus();
                              

                              final newPost = Post(
                                  title: titleController.text.trim(),
                                  description: desController.text.trim(),
                                  userId: id,
                                  likes: 0,

                              );
                              final response = await ref.read(crudProvider).createPost(
                            image: image!,
                                post: newPost
                              );

                              if(response == 'success'){
                                Navigator.of(context).pop();
                              }else{
                                print(response);
                              }

                            }
                          }, child: Text('Create post')),
                          SizedBox(
                            height: 20,
                          ),

                        ],
                      ),
                    );
                  }
              ),
            ),
          ),
        ),
      ),
    );
  }
}
