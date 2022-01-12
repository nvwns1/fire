import 'dart:io';

import 'package:fire/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class SignUpScreen extends StatelessWidget {

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final userNameController = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _form,
          child: Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Consumer(
                    builder: (context, ref, child) {
                      final image = ref.watch(imageProvider).image;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 50,),
                            Text('SignUp', style: TextStyle(fontSize: 35),),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'please provide userName';
                                } else {
                                  return null;
                                }
                              },
                              controller: userNameController,
                              decoration: InputDecoration(
                                label: Text('userName'),
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              validator: (val) {
                                if (!val!.contains('@') || val.isEmpty) {
                                  return 'please provide email';
                                } else {
                                  return null;
                                }
                              },
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                label: Text('email'),
                              ),
                            ),
                            SizedBox(height: 15,),
                            InkWell(
                              onTap: (){
                                ref.read(imageProvider).getImage();
                              },
                              child: Container(
                                width: double.infinity,
                                height: 120,
                                child: image == null ? Center(child: Text('please select an image'),) :
                                Image.file(File(image.path), fit: BoxFit.cover,),
                              ),
                            ),
                            SizedBox(height: 15,),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'please provide password';
                                } else {
                                  return null;
                                }
                              },
                              controller: passController,
                              obscureText: true,
                              decoration: InputDecoration(
                                label: Text('password'),
                              ),
                            ),
                            SizedBox(height: 15,),
                            ElevatedButton(
                                onPressed: () async{
                                  _form.currentState!.save();
                                  if (_form.currentState!.validate()) {
                                    FocusScope.of(context).unfocus();
                                    final response =  await ref.read(fireAuthProvider).signUp(
                                        email: emailController.text.trim(),
                                        password: passController.text.trim(),
                                        userName: userNameController.text.trim(),
                                        image: image!
                                    );

                                    if(response == 'success'){
                                      Navigator.of(context).pop();
                                    }else{
                                      print(response);
                                    }
                                  }
                                }, child: Text('SignUp')
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Text('Already have an Account'),
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }, child: Text('Login'))
                              ],
                            )
                          ],
                        ),
                      );
                    }
                ),
              )
          ),
        )
    );
  }
}