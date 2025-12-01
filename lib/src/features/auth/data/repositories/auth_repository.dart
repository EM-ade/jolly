import 'package:dio/dio.dart';
import '../../../../core/network/api_client.dart';
import '../../../../core/services/secure_storage_service.dart';
import '../models/user_model.dart';

class AuthRepository {
  final ApiClient _apiClient;
  final SecureStorageService _storageService;

  AuthRepository({ApiClient? apiClient, SecureStorageService? storageService})
    : _apiClient = apiClient ?? ApiClient(),
      _storageService = storageService ?? SecureStorageService();

  Future<AuthResponse> login({
    required String phoneNumber,
    required String password,
  }) async {
    try {
      final formData = FormData.fromMap({
        'phone_number': phoneNumber,
        'password': password,
      });

      final response = await _apiClient.dio.post(
        '/api/auth/login',
        data: formData,
      );

      final authResponse = AuthResponse.fromJson(response.data['data']);

      // Save token
      await _storageService.saveToken(authResponse.token);

      return authResponse;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw Exception('Invalid phone number or password');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Phone number not found');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    }
  }

  Future<void> logout() async {
    try {
      await _apiClient.dio.post('/api/auth/logout');
    } catch (e) {
      // Continue with local logout even if API call fails
    } finally {
      await _storageService.deleteToken();
    }
  }

  Future<bool> isAuthenticated() async {
    return await _storageService.hasToken();
  }
}
