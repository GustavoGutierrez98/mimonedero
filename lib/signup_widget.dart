import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mimonedero/main.dart';
import 'package:mimonedero/utils.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;

  const SignUpWidget({
    Key? key,
    required this.onClickedSignIn,
    }):super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

@override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child:Form(
      key: formKey,
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        const FlutterLogo(size: 120),
        const SizedBox(height: 20),
        const Text('Que tal, Bienvenido de vuelta',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 32,fontWeight: FontWeight.normal)        
        ),
        const SizedBox(height: 40),
        TextFormField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Email'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (email)=>
          email !=null && EmailValidator.validate(email)
          ? 'ingresa un correo electronico valido'
          : null,
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: passwordController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(labelText: 'Password'),
          obscureText: true,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value)=>value !=null && value.length < 6
          ? 'Ingresa un minimo de 6 caracteres'
          : null,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(50),
        ),
        icon: const Icon(Icons.arrow_forward, size: 30),
        label: const Text('Registrarse',
        style: TextStyle(fontSize: 24),
        ),
        onPressed: signUp,
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            style: const TextStyle(color: Colors.white),
            text: 'Ya tienes una cuenta?',
            children: [
          TextSpan(recognizer: TapGestureRecognizer()
          ..onTap = widget.onClickedSignIn,
          text: 'Iniciar sesion',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Theme.of(context).colorScheme.secondary)
          ),
            ]
            )
          )
      ],
      ),
    )
    
  );
  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
    context: context, 
    barrierDismissible: false,
    builder: (context)=> const Center(child: CircularProgressIndicator(),)
    );

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        );
    }
    on FirebaseAuthException catch(e){
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}