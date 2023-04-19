// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart' show User;
import 'package:flutter/foundation.dart';

/*
 TODO @immutable
 * 
 * - [@immutable] on top of any class means that the data in that class and all
 * of its subclasses will be immutable means won't change.
 * 
 */
@immutable
class AuthUser {
  final bool isEmailVerified;
  const AuthUser(
    this.isEmailVerified,
  );

  factory AuthUser.fromFirebase(User user) => AuthUser(user.emailVerified);
}
