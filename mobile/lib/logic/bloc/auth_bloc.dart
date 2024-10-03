import 'package:bloc/bloc.dart';
import 'package:hotel_flutter/data/repositories/auth_repository.dart';
import 'package:hotel_flutter/logic/bloc/auth_event.dart';
import 'package:hotel_flutter/logic/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<SignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.register(event.signUpModel);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError('Registration failed: ${e.toString()}'));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.login(event.email, event.password);
        emit(AuthenticatedLogin(user));
      } catch (e) {
        emit(AuthError('Login failed: ${e.toString()}'));
      }
    });

    on<ForgotPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.forgotPassword(event.email);
        emit(const AuthSuccess('Reset link sent to your email'));
      } catch (e) {
        emit(AuthError('Failed to send reset link: ${e.toString()}'));
      }
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.resetPassword(
            event.token, event.newPassword, event.confirmPassword);
        emit(const AuthSuccess('Password reset successful'));
      } catch (e) {
        emit(AuthError('Failed to reset password: ${e.toString()}'));
      }
    });

    on<GetUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await authRepository.getUser(event.userId);
        emit(Authenticated(user));
      } catch (e) {
        emit(AuthError('Failed to fetch user data: ${e.toString()}'));
      }
    });

    on<ChangePasswordEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.updatePassword(
          event.oldPassword,
          event.newPassword,
          event.confirmPassword,
        );
        emit(const AuthSuccess('Password changed successfully'));
      } catch (e) {
        emit(AuthError('Failed to change password: ${e.toString()}'));
      }
    });

    on<UpdateUserEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.updateUser(event.user);
        emit(Authenticated(event.user));
      } catch (error) {
        emit(AuthError('Failed to update user: $error'));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.logout();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthError('Failed to logout: ${e.toString()}'));
      }
    });
  }
}