enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  const Gender(this.label);

  final String label;

  static Gender? fromStorage(String value) {
    for (final gender in Gender.values) {
      if (gender.name == value) {
        return gender;
      }
    }
    return null;
  }
}

class AppUser {
  final String fullName;
  final String email;
  final String password;
  final Gender gender;

  const AppUser({
    required this.fullName,
    required this.email,
    required this.password,
    required this.gender,
  });
}
