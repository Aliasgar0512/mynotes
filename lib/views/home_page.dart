import 'dart:developer' as devtools;

import 'package:flutter/material.dart';
import 'package:flutter_notes_app/services/auth/auth_service.dart';
import 'package:flutter_notes_app/views/login_view.dart';
import 'package:flutter_notes_app/views/notes_view.dart';
import 'package:flutter_notes_app/views/verify_email_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
