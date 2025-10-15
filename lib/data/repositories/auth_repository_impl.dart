import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:onlycation_app/core/constants/app_constants.dart';
import 'package:onlycation_app/data/models/auth/login_request.dart';
import 'package:onlycation_app/data/models/auth/login_response.dart';
import 'package:onlycation_app/data/repositories/auth/login_api_service.dart';
import 'package:onlycation_app/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final LoginApiService _api;
  final SharedPreferences _prefs;

  AuthRepositoryImpl(Dio dio, this._prefs) : _api = LoginApiService(dio);

  @override
  Future<LoginResponse> login(LoginRequest request) async {
    final resp = await _api.login(request);
    if (resp.success && resp.token.isNotEmpty) {
      await _prefs.setString(AppConstants.authTokenKey, resp.token);
    }
    return resp;
  }
}
