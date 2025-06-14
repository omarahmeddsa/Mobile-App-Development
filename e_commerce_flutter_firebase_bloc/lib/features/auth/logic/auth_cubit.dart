import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/data/authbase.dart';
import 'package:untitled/features/auth/logic/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn(String email, String password) async {
    emit(AuthInitial());
    authbase userInstance = authbase(email: email, password: password);
    try {
      // Simulate a sign-in process
      User? user;
      UserCredential? credential = await userInstance.signIn(
        userInstance.email,
        userInstance.password,
      );
      user = credential?.user;
      emit(AuthLoading(user, userInstance.status));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, userInstance.status));
    }
  }

  void signOut(authbase cred) async {
    emit(AuthInitial());

    try {
      await cred.auth.signOut();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, AuthStatus.signedOut));
    }
  }

  void signUp(String email, String password) async {
    emit(AuthInitial());
    authbase userInstance = authbase(email: email, password: password);
    User? user;
    try {
      UserCredential? credential = await userInstance.signUp(
        userInstance.email,
        userInstance.password,
      );
      user = credential?.user;
      if (credential != null) {
        userInstance.status = AuthStatus.signedIn;
        userInstance.user = credential.user;
        emit(AuthLoading(user, userInstance.status));
      } else {
        emit(
          AuthFailure(
            FirebaseAuthException(
              code: 'signup-failed',
              message: 'Failed to create account',
            ),
            AuthStatus.signedOut,
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, AuthStatus.signedOut));
    }
  }

  void resetPassword(authbase cred, String email) async {
    try {
      await cred.resetPassword(cred.email);
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, AuthStatus.signedOut));
    }
  }

  void facebookSignIn() async {
    emit(AuthInitial());
    authbase userInstance = authbase(email: '', password: '');
    try {
      UserCredential? credential = await userInstance.signInWithFacebook();
      emit(AuthLoading(credential.user, userInstance.status));
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, userInstance.status));
    }
  }

  void googleSignIn(authbase cred) async {
    emit(AuthInitial());
    authbase userInstance = authbase(email: '', password: '');
    try {
      await cred.signInWithGoogle();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, userInstance.status));
    }
  }
}
