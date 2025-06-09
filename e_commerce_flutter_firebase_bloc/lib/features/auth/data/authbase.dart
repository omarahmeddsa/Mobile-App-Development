import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus { initialState, signedIn, signedOut, loading, initial }

class authbase {
  FirebaseAuth auth = FirebaseAuth.instance;
  String firstname;
  String lastname;
  String email;
  String password;
  AuthStatus status = AuthStatus.signedOut;
  FirebaseAuthException? error;
  User? user;

  authbase({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.password,
    this.user,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'password': password,
      'status': status,
      'user': user,
      'error': error?.message ?? 'No error',
    };
  }

  void formJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    user = json['user'];
    error = json['error'] ?? 'No error';
  }

  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      status = AuthStatus.signedOut;
    } on FirebaseAuthException catch (e) {
      error = FirebaseAuthException(
        code: e.code,
        message: e.message ?? 'An error occurred while resetting the password.',
      );
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger Facebook sign-in
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status != LoginStatus.success) {
      throw Exception('Facebook login failed: ${result.message}');
    }

    // Get Facebook credential
    final OAuthCredential credential = FacebookAuthProvider.credential(
      result.accessToken!.tokenString,
    );

    // Sign in with Firebase
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      status = AuthStatus.signedOut;
      user = null;
    } catch (e) {
      error = FirebaseAuthException(
        code: 'sign-out-error',
        message: 'An error occurred while signing out.',
      );
    }
  }

  Future<UserCredential?> signUp(String email, String password) async {
    try {
      status = AuthStatus.loading;
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        error = FirebaseAuthException(
          code: 'weak-password',
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        error = FirebaseAuthException(
          code: 'email-already-in-use',
          message: 'The account already exists for that email.',
        );
      }
      return null;
    }
  }

  Future<UserCredential?> signIn(String email, String password) async {
    try {
      status = AuthStatus.loading;
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      status = AuthStatus.signedIn;
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        error = FirebaseAuthException(
          code: 'wrong-password',
          message:
              'The password is invalid or the user does not have a password.',
        );
      } else if (e.code == 'user-not-found') {
        error = FirebaseAuthException(
          code: 'user-not-found',
          message: 'No user found for that email.',
        );
      } else {
        error = FirebaseAuthException(
          code: e.code,
          message: e.message ?? 'An unknown error occurred.',
        );
      }
      return null;
    }
  }
}
