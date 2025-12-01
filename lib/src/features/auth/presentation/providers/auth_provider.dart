import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';

part 'auth_provider.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;
  const factory AuthState.authenticated(User user) = _Authenticated;
  const factory AuthState.error(String message) = _Error;
}

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const AuthState.initial();
  }

  Future<void> login(String phoneNumber, String password) async {
    state = const AuthState.loading();

    try {
      final authResponse = await _authRepository.login(
        phoneNumber: phoneNumber,
        password: password,
      );

      state = AuthState.authenticated(authResponse.user);
    } catch (e) {
      state = AuthState.error(e.toString().replaceAll('Exception: ', ''));
    }
  }

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState.initial();
  }

  Future<void> checkAuthStatus() async {
    final isAuthenticated = await _authRepository.isAuthenticated();
    if (!isAuthenticated) {
      state = const AuthState.initial();
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final authProvider = NotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
