class Profile {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? avatarUrl;

  Profile({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
  });

  factory Profile.fromJson(Map<String, dynamic> json, String email) {
    return Profile(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'],
      role: json['role'] ?? 'user',
      avatarUrl: json['avatar_url'],
    );
  }
}
