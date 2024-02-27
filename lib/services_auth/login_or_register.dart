import 'package:flutter/material.dart';
import 'package:minimal_chats/pages/login_page.dart';
import 'package:minimal_chats/pages/register_page.dart';

class LogiOrRegister extends StatefulWidget {
  const LogiOrRegister({Key? key}) : super(key: key);

  @override
  State<LogiOrRegister> createState() => _LogiOrRegisterState();
}

class _LogiOrRegisterState extends State<LogiOrRegister> {

  bool showLoginPage = true;

  //toggle between login andd register page
  void togglePage(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(onTap: togglePage);
    }  else{
      return RegisterPage(onTap: togglePage);
    }
  }
}
