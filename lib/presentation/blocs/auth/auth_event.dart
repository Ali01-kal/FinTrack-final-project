// // Слой: presentation | Назначение: события AuthBloc

// part of 'auth_bloc.dart';

// abstract class AuthEvent extends Equatable {
//   const AuthEvent();

//   @override
//   List<Object?> get props => [];
// }

// class AuthLoginRequested extends AuthEvent {
//   const AuthLoginRequested({required this.email, required this.password});

//   final String email;
//   final String password;

//   @override
//   List<Object?> get props => [email, password];
// }

// class AuthRegisterRequested extends AuthEvent {
//   const AuthRegisterRequested({
//     required this.name,
//     required this.email,
//     required this.password,
//   });

//   final String name;
//   final String email;
//   final String password;

//   @override
//   List<Object?> get props => [name, email, password];
// }

// class AuthCheckSessionRequested extends AuthEvent {
//   const AuthCheckSessionRequested();
// }

// class AuthLogoutRequested extends AuthEvent {
//   const AuthLogoutRequested();
// }



abstract class AuthEvent {}

class AuthCheckRequested extends AuthEvent {}

class AuthSignInRequested extends AuthEvent {
  final String email;
  final String password;
  AuthSignInRequested(this.email, this.password);
}

class AuthSignUpRequested extends AuthEvent {
  final String email;
  final String password;
  AuthSignUpRequested(this.email, this.password);
}

class AuthSignOutRequested extends AuthEvent {}

class AuthProfileUpdateRequested extends AuthEvent {
  final String name;
  final String email;
  AuthProfileUpdateRequested({required this.name, required this.email});
}
