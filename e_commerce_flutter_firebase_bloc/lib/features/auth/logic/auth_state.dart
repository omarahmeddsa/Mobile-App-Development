import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/features/auth/data/authbase.dart';

sealed class AuthState extends Equatable {
  final AuthStatus status;

  const AuthState(this.status);

  @override
  List<Object?> get props => [status];
}

class AuthInitial extends AuthState {
  const AuthInitial() : super(AuthStatus.initial);
}

class AuthLoading extends AuthState {
  final User? user;

  const AuthLoading(this.user, AuthStatus status) : super(status);

  @override
  List<Object?> get props => [user, status];
}

class AuthSignedOut extends AuthState {
  const AuthSignedOut(AuthStatus status) : super(status);

  List<Object?> get props => [status];
}

class AuthFailure extends AuthState {
  final FirebaseAuthException error;

  const AuthFailure(this.error, AuthStatus status) : super(status);

  @override
  List<Object?> get props => [error, status];
}
