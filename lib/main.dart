import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_notes_app/views/login_view.dart';
import 'package:flutter_notes_app/views/register_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // final user = FirebaseAuth.instance.currentUser;
            // debugPrint(user.toString());
            // if (user?.emailVerified ?? false) {
            //   debugPrint('User is Verified');
            //   return const Text('Done');
            // } else {
            //   debugPrint('User need to Verify your email first');
            //   return const VerifyEmailView();
            // }
            return const LoginView();

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}


