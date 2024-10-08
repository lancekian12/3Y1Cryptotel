import 'dart:io';
import 'package:hotel_flutter/data/data_provider/auth/auth_data_provider.dart';
import 'package:hotel_flutter/data/model/auth/login_model.dart';
import 'package:hotel_flutter/data/model/auth/signup_model.dart';
import 'package:hotel_flutter/data/model/auth/user_model.dart';

class AuthRepository {
  final AuthDataProvider dataProvider;
  UserModel? _cachedUser;

  AuthRepository(this.dataProvider);

  //! Register
  Future<UserModel> register(
      SignUpModel signUpModel, File? profilePicture) async {
    try {
      final data = await dataProvider.register(signUpModel, profilePicture);
      return UserModel.fromJson(data);
    } catch (e) {
      throw Exception('Failed to register: ${e.toString()}');
    }
  }

  //! Login
  Future<LoginModel> login(String email, String password) async {
    try {
      final data = await dataProvider.login(email, password);
      return LoginModel.fromJson(data);
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
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

  //! Fetch all users with filtering conditions
  Future<List<UserModel>> fetchAllUsers() async {
    try {
      final users = await dataProvider.fetchAllUsers();

      // Filter users where active == true, verified == true, hasCompletedOnboarding == true, and roles == 'user'
      final filteredUsers = users
          .where((user) =>
              user.active != false &&
              user.verified == true &&
              user.hasCompletedOnboarding == true &&
              user.roles == "user")
          .toList();

      return filteredUsers; // Return the filtered list
    } catch (error) {
      throw Exception('Failed to fetch all users: $error');
    }
  }

  //! Update Password
  Future<void> updatePassword(String currentPassword, String newPassword,
      String confirmPassword) async {
    final response = await dataProvider.updatePassword(
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

  //! Verify User
  Future<void> verifyUser(String email, String code) async {
    try {
      await dataProvider.verifyUser(email, code);
    } catch (e) {
      throw Exception('Verification failed: ${e.toString()}');
    }
  }

  //! Update user
  Future<void> updateUser(UserModel user, {File? profilePicture}) async {
    try {
      await dataProvider.updateUserData(
        firstName: user.firstName,
        lastName: user.lastName,
        email: user.email,
        profilePicture: profilePicture,
      );
      _cachedUser = user; // Update cached user
    } catch (error) {
      throw Exception('Failed to update user: $error');
    }
  }

  //! Check Onboarding Status
  Future<bool> checkOnboardingStatus(String userId) async {
    try {
      final user = await getUser(userId);
      return user.hasCompletedOnboarding ?? false;
    } catch (e) {
      return false; // Default to false on error
    }
  }

  //! Complete Onboarding
  Future<void> completeOnboarding() async {
    try {
      await dataProvider.completeOnboarding();
      _cachedUser?.hasCompletedOnboarding =
          true; // Update the cached user status
    } catch (e) {
      throw Exception('Failed to complete onboarding: ${e.toString()}');
    }
  }

  //! Clearing Cache
  void clearUserCache() {
    _cachedUser = null;
  }
}
