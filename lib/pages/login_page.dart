import 'package:flutter/material.dart';
import 'package:minimal_chats/components/mt_text_field.dart';
import 'package:minimal_chats/services_auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({Key? key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signIn() async {
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailLangPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey, // Couleur gris au lieu de rose
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0), // Padding global
          child: Column(
            children: [
              SizedBox(height: 100),
              Icon(
                Icons.message,
                size: 80,
                color: Colors.grey[800], // Couleur de l'icône légèrement plus foncée
              ),
              SizedBox(height: 16), // Espacement entre l'icône et le texte
              Text(
                "welcome back you've been missed!",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold, // Pondération de la police ajoutée
                ),
              ),
              SizedBox(height: 36), // Espacement entre le texte et le champ de texte
              MyTextField(
                controller: emailController,
                hintText: "email",
                obscureText: false,
              ),
              SizedBox(height: 16), // Espacement entre les champs de texte
              MyTextField(
                controller: passwordController,
                hintText: "password",
                obscureText: true,
              ),
              SizedBox(height: 16), // Espacement entre le champ de texte et le bouton
              MyButton(onTap: signIn, text: "sign in"),
              SizedBox(height: 16), // Espacement entre le bouton et le texte "Not a member ?"
              Row(
                children: [
                  Text(
                    "Not a member ?",
                    style: TextStyle(
                      fontWeight: FontWeight.bold, // Pondération de la police ajoutée
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      "Register Now",
                      style: TextStyle(
                        color: Colors.blue, // Couleur de texte modifiée en bleu
                        fontWeight: FontWeight.bold, // Pondération de la police ajoutée
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
