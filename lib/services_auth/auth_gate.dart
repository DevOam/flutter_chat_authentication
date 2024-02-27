import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chats/services_auth/login_or_register.dart';

import '../pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream:FirebaseAuth.instance.authStateChanges() ,
        builder: (context, snaphsot){
          if (snaphsot.hasData) {
            return const HomePage();
          }else{
            return const LogiOrRegister();
          }
        }
      ),
    );
  }
}
