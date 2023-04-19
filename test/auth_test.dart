import 'package:flutter_notes_app/services/auth/auth_exceptions.dart';
import 'package:flutter_notes_app/services/auth/auth_provider.dart';
import 'package:flutter_notes_app/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  // TODO group
  //* [group] means to run a set of tests together which are in particular
  //* group.

  group('Mock Authentication', () {
    final provider = MockAuthProvider();
    test('should not be initialized to begin with', () {
      //TODO expect
      //* works just like it name, it expects the value in left side from
      //* right side.
      expect(provider.isInitialized, false);
    });

    test('cannot logout if not initialized', () {
      expect(
          provider.logout(),

          // TODO:throwsA
          //* it works just like it sound which is to match an output related to
          //* an Exception, and [TypeMatcher] is used for creating a matcher for
          //* the given type(in out case [NotInitializedException])

          //! Note: Check the doc for more details.
          throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test('should be able to initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });

    test('should be able to initialized', () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test('user should be null after initialization', () {
      expect(provider.currentUser, null);
    });

    test(
      'should be able to initialize in less than 2 seconds',
      () async {
        await provider.initialize();
        expect(provider.isInitialized, true);
      },

      // TODO timeout
      //* basically the test will fail if the expected result is not
      //* available in the given duration in [timeout]
      timeout: const Timeout(Duration(seconds: 2)),
    );

    test('create user should delegate to login function', () async {
      final badEmailUser = provider.createUser(
        email: 'abc1@gmail.com',
        password: 'password',
      );
      expect(
        badEmailUser,
        throwsA(const TypeMatcher<UserNotFoundAuthException>()),
      );

      final badPasswordUser = provider.createUser(
        email: 'some@gmail.com',
        password: '12345669Fail',
      );
      expect(
        badPasswordUser,
        throwsA(const TypeMatcher<WrongPasswordAuthException>()),
      );

      final user = await provider.createUser(
        email: 'foo',
        password: '123456',
      );
      expect(provider.currentUser, user);

      expect(user.isEmailVerified, false);
    });

    test('login user should be able to verified', () {
      provider.sendEmailVerification();
      final user = provider.currentUser;

      expect(user, isNotNull);
      expect(user!.isEmailVerified, true);
    });

    test('should be able to logout and login again', () async {
      await provider.logout();
      await provider.login(
        email: 'user',
        password: 'password',
      );
      final user = provider.currentUser;
      expect(user, isNotNull);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  var _isInitialized = false;

  bool get isInitialized => _isInitialized;

  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(const Duration(seconds: 1));

    return login(email: email, password: password);
  }

  @override
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(const Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    if (email == 'abc1@gmail.com') throw UserNotFoundAuthException();
    if (password == '12345669Fail') throw WrongPasswordAuthException();
    const user = AuthUser(isEmailVerified: false);
    _user = user;
    return Future.value(user);
  }

  @override
  Future<void> logout() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user == null) throw UserNotFoundAuthException();
    await Future.delayed(const Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    final user = _user;
    if (user == null) throw UserNotFoundAuthException();
    const newUser = AuthUser(isEmailVerified: true);
    _user = newUser;
  }
}
