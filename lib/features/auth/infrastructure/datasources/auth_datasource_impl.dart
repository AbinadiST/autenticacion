

import 'package:teslo_shop/features/auth/domain/domain.dart';

class AuthDataSoruceImpl extends AuthDataSource {
  @override
  Future<User> checkAuthStatus(String token) {
    
    throw UnimplementedError();
  }

  @override
  Future<User> login(String email, String password) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    // TODO: implement register
    throw UnimplementedError();
  }

}