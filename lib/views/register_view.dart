import 'package:flutter/material.dart';
import 'package:flutter_notes_app/constants/routes.dart';
import 'package:flutter_notes_app/services/auth/auth_exceptions.dart';
import 'package:flutter_notes_app/services/auth/auth_service.dart';
import 'package:flutter_notes_app/utilities/show_error_dialog.dart';

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
                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;

                if (user != null) {
                  if (context.mounted) {
                    Navigator.of(context).pushNamed(verifyEmailRoute);
                  }
                }
                await AuthService.firebase().sendEmailVerification();
              } on WeakPasswordAuthException catch (_) {
                await showErrorDialog(
                  context,
                  'Password is too weak',
                );
              } on EmailAlreadyInUseAuthException catch (_) {
                await showErrorDialog(
                  context,
                  'Email is already registered',
                );
              } on InvalidEmailAuthException catch (_) {
                await showErrorDialog(
                  context,
                  'Invalid Email Id',
                );
              } on GenericAuthException catch (_) {
                await showErrorDialog(
                  context,
                  'Failed to Register',
                );
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
