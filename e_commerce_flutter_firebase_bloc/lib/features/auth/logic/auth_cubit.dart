import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/features/auth/data/authbase.dart';
import 'package:untitled/features/auth/logic/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void SigIn(authbase cred) async {
    emit(AuthInitial());
    try {
      // Simulate a sign-in process
      await Future.delayed(Duration(seconds: 2));
      UserCredential? credential = await cred.signIn(cred.email, cred.password);
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, cred));
    }
  }

  void SignOut(authbase cred) async {
    emit(AuthLoading(cred));
    try {
      await cred.auth.signOut();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, cred));
    }
  }

  void SignUp(authbase cred) async {
    emit(AuthLoading(cred));
    try {
      // Simulate a sign-up process
      await Future.delayed(Duration(seconds: 2));
      UserCredential? credential = await cred.signUp(cred.email, cred.password);
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, cred));
    }
  }

  void ResetPassword(authbase cred, String email) async {
    emit(AuthLoading(cred));
    try {
      await cred.resetPassword(cred.email);
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, cred));
    }
  }

  void FacebookSignIn(authbase cred) async {
    emit(AuthLoading(cred));
    try {
      UserCredential? credential = await cred.signInWithFacebook();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, cred));
    }
  }

  void GoogleSignIn(authbase cred) async {
    emit(AuthLoading(cred));
    try {
      UserCredential? credential = await cred.signInWithGoogle();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e, cred));
    }
  }
}
