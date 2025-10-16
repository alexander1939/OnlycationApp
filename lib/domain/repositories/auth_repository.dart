import 'package:onlycation_app/data/models/auth/login_request.dart';
import 'package:onlycation_app/data/models/auth/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);
}
