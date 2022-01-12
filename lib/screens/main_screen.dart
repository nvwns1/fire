
import 'package:fire/provider/auth_provider.dart';
import 'package:fire/widgets/post_add_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class MainScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        actions: [
          TextButton(
            onPressed: () async{
              await ref.read(fireAuthProvider).logOut();

            },
            child: Text('Sign Out'),
          )
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Get.to(()=> PostAddScreen());
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
