class SignUpModel {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  final String? profilePicture; // Make this nullable

  SignUpModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.profilePicture, // Nullable field
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'profilePicture': profilePicture ?? '', // Optional field
    };
  }
}