import 'package:flutter/material.dart';
import 'package:flutter_notes_app/views/home_page.dart';
import 'package:flutter_notes_app/views/login_view.dart';
import 'package:flutter_notes_app/views/notes_view.dart';
import 'package:flutter_notes_app/views/register_view.dart';

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
        '/notes/': (context) => const NotesView(),
      },
    ),
  );
}
