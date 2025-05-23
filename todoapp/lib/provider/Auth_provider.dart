import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthState { loading, loggedIn, loggedOut }

class Auth_Provider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  User? _user;
  AuthState? _authState;
  FirebaseAuthException? errMsg;

  AuthState get authState => _authState ?? AuthState.loggedOut;
  Auth_Provider() {
    _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        _authState = AuthState.loggedOut;
      } else {
        _authState = AuthState.loggedIn;
      }
      notifyListeners();
    });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      _authState = AuthState.loading;
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      notifyListeners();
      if (googleUser == null) {
        // User canceled the sign-in
        _authState = AuthState.loggedOut;
        return null;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a credential for Firebase
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      _authState = AuthState.loggedIn;
      notifyListeners();
      return userCredential;
    } catch (e) {
      print('Google sign-in error: $e');
      _authState = AuthState.loggedOut;
      notifyListeners();
      return null;
    }
  }

  Future<void> SignOut() async {
    _authState = AuthState.loading;
    notifyListeners();

    // Sign out the user
    await _auth.signOut();

    _authState = AuthState.loggedOut;
    notifyListeners();
  }

  Future<UserCredential?> signIn(String? email, String? password) async {
    try {
      if (email == null || password == null) {
        throw FirebaseAuthException(
          code: 'invalid-arguments',
          message: 'Email and password cannot be null',
        );
      }

      _authState = AuthState.loading;
      notifyListeners();

      // Attempt to sign in with email and password
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        _user = credential.user;
        _authState = AuthState.loggedIn;
        notifyListeners();
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      _authState = AuthState.loggedOut;
      _user = null;
      errMsg = e;
      notifyListeners();
      return null;
    } catch (e) {
      _authState = AuthState.loggedOut;
      _user = null;
      errMsg = FirebaseAuthException(
        code: 'unknown-error',
        message: 'An unexpected error occurred: $e',
      );
      notifyListeners();
      return null;
    }
  }

  Future<UserCredential?> createaccount(String? email, String? password) async {
    try {
      if (email == null || password == null) {
        throw FirebaseAuthException(
          code: 'invalid-arguments',
          message: 'Email and password cannot be null',
        );
      }

      _authState = AuthState.loading;
      notifyListeners();

      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (credential.user != null) {
        _user = credential.user;
        _authState = AuthState.loggedIn;
        notifyListeners();
      }
      return credential;
    } on FirebaseAuthException catch (e) {
      _authState = AuthState.loggedOut;
      _user = null;
      errMsg = e;
      notifyListeners();
      return null;
    } catch (e) {
      _authState = AuthState.loggedOut;
      _user = null;
      errMsg = FirebaseAuthException(
        code: 'unknown-error',
        message: 'An unexpected error occurred: $e',
      );
      notifyListeners();
      return null;
    }
  }
}
