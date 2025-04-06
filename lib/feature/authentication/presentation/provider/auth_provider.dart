import 'package:digital_canteen/feature/authentication/domain/repositoy/auth_repository.dart';
import 'package:digital_canteen/feature/authentication/presentation/provider/auth_state.dart';
import 'package:digital_canteen/shared/helpers/logger.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final authStateProvider =
    AutoDisposeStateNotifierProvider<AuthProvider, AuthState>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return AuthProvider(repo);
});

class AuthProvider extends StateNotifier<AuthState> {
  AuthProvider(this.authRepositoy) : super(const AuthState.initail());
  final AuthRepositoy authRepositoy;

  //login Feature
  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(concreteState: AuthStateConcrete.loading);
    // await Future.delayed(const Duration(seconds: 3));
    final response =
        await authRepositoy.signIn(email: email, password: password);
    response.fold(
      (exception) {
        state = state.copyWith(
            concreteState: AuthStateConcrete.error, exception: exception);
      },
      (user) {
        state = state.copyWith(
            user: user, concreteState: AuthStateConcrete.loggedIn);
      },
    );
  }

  //Register Feature
  Future<void> register({
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    state = state.copyWith(concreteState: AuthStateConcrete.loading);
    final response = await authRepositoy.registerUser(
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        userName: userName);

    response.fold(
      (l) {
        logger.e(l);
        state = state.copyWith(
            concreteState: AuthStateConcrete.error, exception: l);
      },
      (r) {
        logger.e(r);
        state = state.copyWith(concreteState: AuthStateConcrete.initial);
      },
    );
  }

  //logout Feature
  Future<void> signOut() async {
    state = state.copyWith(concreteState: AuthStateConcrete.loading);
    // await Future.delayed(const Duration(seconds: 3));
    final response = await authRepositoy.signOut();
    response.fold(
      (exception) {
        state = state.copyWith(
            concreteState: AuthStateConcrete.error, exception: exception);
      },
      (_) {
        state = state.copyWith(concreteState: AuthStateConcrete.loggedIn);
      },
    );
  }
}
