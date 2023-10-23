import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mimonedero/main.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({
    Key? key,
    required this.onClickedSignUp,
  }) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String errorText = ''; // Variable para almacenar el mensaje de error.

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
              onChanged: (text) {
                setState(() {
                  errorText = ''; // Borrar el mensaje de error al modificar el campo de correo.
                });
              },
              decoration: const InputDecoration(labelText: 'Correo Electrónico'),
            ),
            const SizedBox(
              height: 4,
            ),
            TextField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              onChanged: (text) {
                setState(() {
                  errorText = ''; // Borrar el mensaje de error al modificar el campo de contraseña.
                });
              },
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            Text(
              errorText, // Mostrar el mensaje de error.
              style: TextStyle(color: Colors.red),
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
              ),
            ),
          ],
        ),
      );

  Future signIn() async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(child: CircularProgressIndicator())
  );

  final email = emailController.text.trim();
  final password = passwordController.text.trim();
  
  if (email.isEmpty || password.isEmpty) {
    setState(() {
      errorText = 'Por favor, completa todos los campos.';
    });

    // Cerrar el diálogo de progreso.
    Navigator.of(context).pop();
    
    return; // No intentar iniciar sesión si hay campos vacíos.
  }

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    setState(() {
      errorText = 'Correo o contraseña incorrectos';
    });
  }

  // Cerrar el diálogo de progreso después de intentar iniciar sesión.
  Navigator.of(context).pop();

  navigatorKey.currentState!.popUntil((route) => route.isFirst);
}

}
