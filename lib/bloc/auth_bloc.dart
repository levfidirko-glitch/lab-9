import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted e,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1));

    
    final emailOk = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(e.email);
    if (!emailOk || e.password.length < 6) {
      emit(AuthFailure('Registration failed: invalid data'));
      return;
    }

    emit(AuthSuccess(
      name: e.name,
      phone: e.phone,
      email: e.email,
      story: e.story,
    ));
  }
}
