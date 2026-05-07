import 'dart:io';

import 'package:sipekatbc/models/profile_model.dart';
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

  Future<Profile> getProfile() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User tidak ditemukan');
    }

    try {
      final res = await _client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .single();

      return Profile.fromJson(res, user.email ?? '');
    } on PostgrestException catch (e) {
      if (e.code != 'PGRST116') {
        rethrow;
      }

      return Profile(
        id: user.id,
        name: user.userMetadata?['name'] ?? '',
        email: user.email ?? '',
        role: 'user',
        avatarUrl: null,
      );
    }
  }

  Future<String> uploadAvatar(String filePath) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User tidak ditemukan');
    }

    final fileName = '${user.id}/avatar.jpg';

    await _client.storage
        .from('avatars')
        .upload(
          fileName,
          File(filePath),
          fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
        );

    final publicUrl = _client.storage.from('avatars').getPublicUrl(fileName);
    final cacheBustedUrl =
        '$publicUrl?v=${DateTime.now().millisecondsSinceEpoch}';

    return cacheBustedUrl;
  }

  Future<void> updateAvatar(String url) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw Exception('User tidak ditemukan');
    }

    await _client
        .from('profiles')
        .update({'avatar_url': url})
        .eq('id', user.id);
  }
}
