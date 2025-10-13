import 'package:dio/dio.dart';

class LoginApi {
  final Dio _dio;
  
  LoginApi(this._dio);

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        'auth/login/',
        data: {
          'email': email,
          'password': password,
        },
      );
      
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      return {
        'success': false,
        'message': e.response?.data?['message'] ?? 'Error de autenticación',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión. Intente nuevamente.',
      };
    }
  }
}
