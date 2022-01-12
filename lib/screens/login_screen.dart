import 'package:fire/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _form,
          child: Card(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Log In',
                  style: TextStyle(
                    fontSize: 40
                  ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,

                    validator: (val){
                      if(!val!.contains('@') || val.isEmpty){
                        return 'Please provide email address';
                      }else{
                        return null;
                      }
                    },


                    decoration: InputDecoration(label: Text('Email'),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: passController,

                    obscureText: true,
                    validator: (val){
                      if(val!.isEmpty){
                        return 'please provide password';
                      }
                    },
                    decoration: InputDecoration(

                        label: Text('Password'),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                    )
                    ),
                    
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Consumer(
                      builder: (context, ref, child){


                        return  ElevatedButton(onPressed: () async{

                          _form.currentState!.save();
                          if(_form.currentState!.validate()){
                            //keyboard tala jharxa
                            FocusScope.of(context).unfocus();
                            await ref.read(fireAuthProvider).signIn(
                                email: emailController.text.trim(),
                                password: passController.text.trim(),
                                );


                          }
                        }, child: Text('Sign In'));
                      }
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text('Don\'t have an account?'),
                      TextButton(
                        onPressed: () {
                          Get.to(()=> SignUpScreen());
                        },
                        child: Text('Sign Up'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
