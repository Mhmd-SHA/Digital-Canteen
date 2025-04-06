import 'package:digital_canteen/shared/exceptions/app_exception.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

// class GenreState extends Equatable {
//   final List<Genre> genres;
//   final bool hasData;
//   final String message;
//   final GenreConcreteState state;
//   final bool isLoading;

//   const GenreState(
//       {this.genres = const [],
//       this.hasData = false,
//       this.message = '',
//       this.state = GenreConcreteState.initial,
//       this.isLoading = false});

//   const GenreState.initial(
//       {this.genres = const [],
//       this.hasData = false,
//       this.message = '',
//       this.state = GenreConcreteState.initial,
//       this.isLoading = false});

//   GenreState copyWith(
//       {List<Genre>? genres,
//       bool? hasData,
//       String? message,
//       GenreConcreteState? state,
//       bool? isLoading}) {
//     return GenreState(
//         genres: genres ?? this.genres,
//         message: message ?? this.message,
//         hasData: hasData ?? this.hasData,
//         state: state ?? this.state,
//         isLoading: isLoading ?? this.isLoading);
//   }

//   @override
//   List<Object?> get props => [genres, message, hasData, state, isLoading];
// }

class AuthState extends Equatable {
  final User? user;
  final AppException? exception;
  final AuthStateConcrete concreteState;

  const AuthState({
    required this.concreteState,
    this.user,
    this.exception,
  });

  const AuthState.initail({
    this.user,
    this.exception,
    this.concreteState = AuthStateConcrete.initial,
  });

  @override
  List<Object?> get props => [user, exception, concreteState];
  AuthState copyWith(
      {User? user, AppException? exception, AuthStateConcrete? concreteState}) {
    return AuthState(
        user: user ?? this.user,
        exception: exception ?? this.exception,
        concreteState: concreteState ?? this.concreteState);
  }
}

enum AuthStateConcrete { initial, loading, error, loggedIn }
