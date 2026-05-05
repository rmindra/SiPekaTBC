import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:sipekatbc/service/supabase_client.dart';

class AuthRepository {
  final _client = supabase;

  Future<AuthResponse> login({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> register({
    required String email,
    required String password,
    required String name,
  }) async {
    final res = await _client.auth.signUp(email: email, password: password);

    final user = res.user;

    if (user != null) {
      await _client.from('profiles').upsert({'id': user.id, 'name': name});
    }

    return res;
  }

  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
