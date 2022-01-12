import 'package:fire/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'login_screen.dart';
import 'main_screen.dart';

class HomeScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    final authWatch = ref.watch(authProvider);
    return authWatch.when(
        data: (data) {
          if (data == null) {
            return LoginScreen();
          } else {
            return MainScreen();
          }
        },
        error: (err, stack) => Text('$err'),
        loading: () => CircularProgressIndicator());
  }
}
