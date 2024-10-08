class UserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? token;
  final String? profilePicture;
  final bool? verified;
  final String? roles;
  bool? hasCompletedOnboarding;
  final bool? active;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.token,
    this.profilePicture,
    this.verified,
    this.roles,
    this.hasCompletedOnboarding,
    this.active,
  });

  // From JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      token: json['token'],
      profilePicture: json['profile'],
      verified: json['verified'],
      roles: json['roles'],
      hasCompletedOnboarding: json['hasCompletedOnboarding'],
      active: json['active'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'profile': profilePicture,
    };
  }
}
