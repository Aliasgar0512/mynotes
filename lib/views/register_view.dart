import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools;

import 'package:flutter_notes_app/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  /*
   TODO TextEditingController
   * 
   * - for getting latest values from text fields
   *
   * 
   * 
   * */
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
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            /*
                        TODO InputDecoration 
                       * 
                       * - we use [InputDecoration] for [TextField] decoration
                       *  
                       */
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
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                devtools.log(e.code);
                devtools.log(e.toString());

                if (e.code == 'weak-password') {
                  devtools.log('Password is too weak');
                } else if (e.code == 'email-already-in-use') {
                  devtools.log('Email is already registered');
                } else if (e.code == 'invalid-email') {
                  devtools.log('Invalid Email Id');
                }
              } catch (e) {
                devtools.log(e.toString());
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
               loginRoute,
                (route) => false,
              );
            },
            child: const Text('Already registered? Login here!'),
          )
        ],
      ),
    );
  }
}
