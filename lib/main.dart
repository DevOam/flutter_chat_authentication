import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:minimal_chats/firebase_options.dart';
import 'package:minimal_chats/pages/login_page.dart';
import 'package:minimal_chats/pages/register_page.dart';
import 'package:minimal_chats/services_auth/auth_gate.dart';
import 'package:minimal_chats/services_auth/auth_service.dart';

import 'package:minimal_chats/services_auth/login_or_register.dart';
import 'package:provider/provider.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(
        create: (context) => AuthService(),
        child: const MyApp(),
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthGate(),
    );
  }
}

