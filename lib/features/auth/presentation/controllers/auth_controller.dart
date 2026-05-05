import 'package:sipekatbc/core/session/user_session.dart';
import 'package:sipekatbc/features/auth/data/auth_repository.dart';
import 'package:sipekatbc/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController {
  final AuthRepository _repository = AuthRepository();

  String? validateName(String value) {
    if (value.isEmpty) return 'Nama wajib diisi';
    return null;
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(email)) {
      return 'Format email tidak valid';
    }
    final lowerEmail = email.toLowerCase();
    if (!lowerEmail.endsWith('@gmail.com')) {
      return 'Email harus menggunakan akun Gmail';
    }
    return null;
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password tidak boleh kosong';
    }
    if (password.length < 8) {
      return 'Password harus minimal 8 karakter';
    }
    return null;
  }

  String? validateConfirmPassword(String? password, String? confirmPassword) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return 'Konfirmasi password tidak boleh kosong';
    }
    if (password != confirmPassword) {
      return 'Password dan konfirmasi password tidak cocok';
    }
    return null;
  }

  Future<String?> login(String email, String password) async {
    final emailError = validateEmail(email);
    final passError = validatePassword(password);

    if (emailError != null) return emailError;
    if (passError != null) return passError;

    try {
      await _repository.login(email: email, password: password);

      final profile = await fetchProfile();

      if (profile != null) {
        UserSession.currentUser = profile;
      }

      return null;
    } catch (e) {
      return 'Login gagal: $e';
    }
  }

  Future<String?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    final nameError = validateName(name);
    final emailError = validateEmail(email);
    final passError = validatePassword(password);

    if (nameError != null) return nameError;
    if (emailError != null) return emailError;
    if (passError != null) return passError;

    if (password != confirmPassword) {
      return "Password tidak sama";
    }

    try {
      await _repository.register(email: email, password: password, name: name);
      return null;
    } on AuthException catch (e) {
      return e.message;
    } catch (_) {
      return "Terjadi kesalahan, coba lagi";
    }
  }

  Future<Profile?> fetchProfile() async {
    try {
      final profile = await _repository.getProfile();
      return profile;
    } catch (_) {
      return null;
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    UserSession.clear();
  }
}
