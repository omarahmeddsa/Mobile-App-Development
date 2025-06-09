import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/features/auth/data/authbase.dart';

sealed class AuthState extends Equatable {
  final authbase Cred;

  AuthState(this.Cred);

  @override
  List<Object?> get props => [Cred];
}

class AuthInitial extends AuthState {
  AuthInitial()
    : super(
        authbase(
          firstname: '',
          lastname: '',
          email: '',
          password: '',
          status: AuthStatus.initialState,
        ),
      );
}

class AuthLoading extends AuthState {
  AuthLoading(authbase Cred) : super(Cred);
}

class AuthFailure extends AuthState {
  FirebaseAuthException error;
  AuthFailure(this.error, authbase Cred) : super(Cred);
}
