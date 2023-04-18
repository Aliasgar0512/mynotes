import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/constants/routes.dart';
import 'package:flutter_notes_app/firebase_options.dart';
import 'dart:developer' as devtools;

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your password here'),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential =
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
                // userCredential.user!=null
                if (context.mounted) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                   notesRoute,
                    (_) => false,
                  );
                }
              } on FirebaseAuthException catch (e) {
                devtools.log(e.runtimeType.toString());
                devtools.log(e.code);
                if (e.code == 'user-not-found') {
                  devtools.log('User Not Found');
                } else if (e.code == 'wrong-password') {
                  devtools.log('Wrong Password');
                }
              } catch (e) {
                devtools.log(e.runtimeType.toString());
                devtools.log(e.toString());
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
               registerRoute,
                (route) => false,
              );
            },
            child: const Text('Not register yet? Register here!'),
          )
        ],
      ),
    );
  }
}
