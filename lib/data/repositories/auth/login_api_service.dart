import 'package:dio/dio.dart';
import '../../models/auth/login_request.dart';
import '../../models/auth/login_response.dart';
import '../../../core/constants/app_constants.dart';

class LoginApiService {
  final Dio _dio;

  LoginApiService(this._dio);

  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await _dio.post(
        '${AppConstants.baseUrl}auth/login/',
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      return LoginResponse(
        token: '',
        success: false,
        message: e.response?.data?['message'] ?? 'Error de autenticación',
      );
    }
  }
}
