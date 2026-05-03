// // Слой: presentation | Назначение: состояния AuthBloc

// part of 'auth_bloc.dart';

// abstract class AuthState extends Equatable {
//   const AuthState();

//   @override
//   List<Object?> get props => [];
// }

// class AuthInitial extends AuthState {
//   const AuthInitial();
// }

// class AuthLoading extends AuthState {
//   const AuthLoading();
// }

// class AuthAuthenticated extends AuthState {
//   const AuthAuthenticated(this.user);

//   final User user;

//   @override
//   List<Object?> get props => [user];
// }

// class AuthUnauthenticated extends AuthState {
//   const AuthUnauthenticated();
// }

// class AuthError extends AuthState {
//   const AuthError(this.message);

//   final String message;

//   @override
//   List<Object?> get props => [message];
// }



import '../../../domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final UserEntity user;
  Authenticated(this.user);
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}