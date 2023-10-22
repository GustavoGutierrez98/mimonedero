import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mimonedero/main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            TextField(
              controller: emailController,
              cursorColor: Colors.orange,
              textInputAction: TextInputAction.next,
              decoration:
                  const InputDecoration(labelText: 'Correo Electronico'),
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50)),
              icon: const Icon(Icons.lock_open, size: 32),
              label: const Text(
                'Iniciar',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: signIn,
            ),
            const SizedBox(height: 24),
            RichText(
                text: TextSpan(
              style: const TextStyle(color: Colors.white, fontSize: 20),
              text: 'No tienes cuenta?',
              /*children: [
        TextSpan(
          recognizer: TapGestureRecognizer()
          ..onTap = widget.onClickedSignUp,
          text: 'Crear cuenta',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.secondary)
          )
      ]*/
            ))
          ],
        ),
      );

  Future signIn() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException catch (e) {
      print(e);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
