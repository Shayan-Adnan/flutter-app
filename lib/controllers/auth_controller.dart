import 'package:assigmment_app/models/app_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class AuthController {
  AuthController._();

  static final AuthController instance = AuthController._();

  static const _fullNameKey = 'registered_full_name';
  static const _emailKey = 'registered_email';
  static const _passwordKey = 'registered_password';
  static const _genderKey = 'registered_gender';
  static const _rememberMeKey = 'remember_me';
  static const _sessionEmailKey = 'session_email';

  AppUser? _registeredUser;
  AppUser? _currentUser;
  bool _initialized = false;

  AppUser? get registeredUser => _registeredUser;
  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;
  AuthStatus get authStatus {
    if (!_initialized) return AuthStatus.unknown;
    if (_currentUser != null) return AuthStatus.authenticated;
    return AuthStatus.unauthenticated;
  }

  Future<void> init() async {
    if (_initialized) return;

    final prefs = await SharedPreferences.getInstance();
    final fullName = prefs.getString(_fullNameKey);
    final email = prefs.getString(_emailKey);
    final password = prefs.getString(_passwordKey);
    final genderRaw = prefs.getString(_genderKey);
    final gender = genderRaw == null ? null : Gender.fromStorage(genderRaw);

    if (fullName != null &&
        email != null &&
        password != null &&
        gender != null) {
      _registeredUser = AppUser(
        fullName: fullName,
        email: email,
        password: password,
        gender: gender,
      );
    }

    final rememberMe = prefs.getBool(_rememberMeKey) ?? false;
    final sessionEmail = prefs.getString(_sessionEmailKey);

    if (rememberMe &&
        sessionEmail != null &&
        _registeredUser != null &&
        _registeredUser!.email.toLowerCase() == sessionEmail.toLowerCase()) {
      _currentUser = _registeredUser;
    }

    _initialized = true;
  }

  Future<void> registerUser(AppUser user) async {
    final prefs = await SharedPreferences.getInstance();

    _registeredUser = user;
    await prefs.setString(_fullNameKey, user.fullName);
    await prefs.setString(_emailKey, user.email);
    await prefs.setString(_passwordKey, user.password);
    await prefs.setString(_genderKey, user.gender.name);

    if (_currentUser != null &&
        _currentUser!.email.toLowerCase() != user.email.toLowerCase()) {
      await logout();
    }
  }

  Future<bool> login({
    required String email,
    required String password,
    required bool rememberMe,
  }) async {
    if (_registeredUser == null) {
      return false;
    }

    final isEmailMatch =
        _registeredUser!.email.toLowerCase() == email.toLowerCase();
    final isPasswordMatch = _registeredUser!.password == password;

    if (!isEmailMatch || !isPasswordMatch) {
      return false;
    }

    final prefs = await SharedPreferences.getInstance();

    _currentUser = _registeredUser;

    if (rememberMe) {
      await prefs.setBool(_rememberMeKey, true);
      await prefs.setString(_sessionEmailKey, _registeredUser!.email);
    } else {
      await prefs.setBool(_rememberMeKey, false);
      await prefs.remove(_sessionEmailKey);
    }

    return true;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    _currentUser = null;
    await prefs.setBool(_rememberMeKey, false);
    await prefs.remove(_sessionEmailKey);
  }
}
