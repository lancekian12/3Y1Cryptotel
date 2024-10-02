import 'package:hotel_flutter/data/data_provider/auth/auth_data_provider.dart';
import 'package:hotel_flutter/data/model/login_model.dart';
import 'package:hotel_flutter/data/model/signup_model.dart';
import 'package:hotel_flutter/data/model/user_model.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  UserModel? _cachedUser; // Cached user data

  AuthRepository(this.dataProvider);

  //! Register
  Future<UserModel> register(SignUpModel signUpModel) async {
    final data = await dataProvider.register(signUpModel);
    return UserModel.fromJson(data);
  }

  //! Login
  Future<LoginModel> login(String email, String password) async {
    try {
      final data = await dataProvider.login(email, password);
      return LoginModel.fromJson(data);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  //! Forgot Password
  Future<void> forgotPassword(String email) async {
    try {
      await dataProvider.forgotPassword(email);
    } catch (e) {
      throw Exception(
          'Did not find any email or an error occurred. Please try again.');
    }
  }

  //! Reset Password
  Future<void> resetPassword(
      String token, String newPassword, String confirmPassword) async {
    return await dataProvider.resetPassword(
        token, newPassword, confirmPassword);
  }

  //! Get user
  Future<UserModel> getUser(String userId) async {
    if (_cachedUser != null) {
      return _cachedUser!;
    }

    try {
      final data = await dataProvider.getUser(userId);
      _cachedUser = data;
      return _cachedUser!;
    } catch (error) {
      throw Exception('Failed to fetch user: $error');
    }
  }

  Future<void> updatePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    final authDataProvider = AuthDataProvider();

    final response = await authDataProvider.updatePassword(
        currentPassword, newPassword, confirmPassword);
    return response;
  }

  //! Logout
  Future<void> logout() async {
    try {
      await dataProvider.logout();
      clearUserCache(); // Clear cache on logout
    } catch (e) {
      throw Exception('Failed to logout: $e');
    }
  }

  //! Clearing Cache
  void clearUserCache() {
    _cachedUser = null;
  }
}
