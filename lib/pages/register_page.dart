import 'package:flutter/material.dart';
import 'package:minimal_chats/components/mt_text_field.dart';
import 'package:minimal_chats/services_auth/auth_service.dart';
import 'package:provider/provider.dart';

import '../components/my_button.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  const RegisterPage({Key? key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController(); // Renommage de la variable

  void signUp() async {
    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    // Obtenir le service d'authentification
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpEmailandPassword(
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
          padding: EdgeInsets.all(16.0), // Ajout de padding global
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
                "Let's create an account for you!", // Correction de la ponctuation
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 24), // Espacement entre le texte et les champs de texte
              MyTextField(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              SizedBox(height: 16), // Espacement entre les champs de texte
              MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              SizedBox(height: 16), // Espacement entre les champs de texte
              MyTextField(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              SizedBox(height: 16), // Espacement entre les champs de texte et le bouton
              MyButton(onTap: signUp, text: "Sign Up"),
              SizedBox(height: 16), // Espacement entre le bouton et le texte "already a member ?"
              Row(
                children: [
                  Text("Already a member ?"),
                  Spacer(),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text("Login now",
                      style: TextStyle(
                        color: Colors.blue, // Couleur de texte modifiée en bleu
                        fontWeight: FontWeight.bold, // Pondération de la police ajoutée
                      ),),
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
