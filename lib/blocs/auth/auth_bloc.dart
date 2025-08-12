import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findoc_assignment/blocs/auth/auth_event.dart';
import 'package:findoc_assignment/blocs/auth/auth_state.dart';
import 'package:findoc_assignment/models/user.dart';
import 'package:findoc_assignment/utils/validation.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final emailError = ValidationUtils.getEmailError(event.email);
    if (emailError != null) {
      emit(AuthFailure(emailError));
      return;
    }
    final passwordError = ValidationUtils.getPasswordError(event.password);
    if (passwordError != null) {
      emit(AuthFailure(passwordError));
      return;
    }

   
    await Future.delayed(const Duration(seconds: 1));

    try {
    
      final user = User(
        email: event.email,
        name: event.email.split('@')[0], 
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure('Login failed: $e'));
    }
  }

  void _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthInitial());
  }
}
