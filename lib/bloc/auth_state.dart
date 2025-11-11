part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  final String name;
  final String phone;
  final String email;
  final String story;

  AuthSuccess({
    required this.name,
    required this.phone,
    required this.email,
    required this.story,
  });
}

final class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}
