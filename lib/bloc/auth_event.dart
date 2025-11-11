part of 'auth_bloc.dart';

sealed class AuthEvent {}

final class RegisterSubmitted extends AuthEvent {
  final String name;
  final String phone;
  final String email;
  final String story;
  final String password;

  RegisterSubmitted({
    required this.name,
    required this.phone,
    required this.email,
    required this.story,
    required this.password,
  });
}
