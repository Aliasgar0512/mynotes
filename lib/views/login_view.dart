import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/firebase_options.dart';

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
      //!
      /*
       TODO :  FutureBuilder
       * 
       * - basically works like we pass the Future and it will perform the 
       *   future and if that future succeeded or fails it will have a callback
       *   where it will ask to return widget to show depending on the result
       *   of the future.
       * 
       * - in short we can display different type of data depending on the 
       *   result like on success we will display the widgets replated to 
       *   that and for failure we can show error to user and show loading while 
       *   the future is executing.
       *    - basically show different output depending on different state.
       */

      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    controller: _email,
                    enableSuggestions: false,
                    autocorrect: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                        hintText: 'Enter your email here'),
                  ),
                  TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                        hintText: 'Enter your password here'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;
                      try {
                        final userCredential = await FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        debugPrint(userCredential.toString());
                        // userCredential.user!=null
                      } on FirebaseAuthException catch (e) {
                        debugPrint(e.runtimeType.toString());
                        debugPrint(e.code);
                        if (e.code == 'user-not-found') {
                          debugPrint('User Not Found');
                        } else if (e.code == 'wrong-password') {
                          debugPrint('Wrong Password');
                        }
                      } catch (e) {
                        debugPrint(e.runtimeType.toString());
                        debugPrint(e.toString());
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              );
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
