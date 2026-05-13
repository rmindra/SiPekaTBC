class Article {
  final String id;
  final String title;
  final String content;
  final String category;
  final String? coverUrl;
  final String? sourceUrl;
  final String? authorId;
  final DateTime? createdAt;

  const Article({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.coverUrl,
    required this.sourceUrl,
    required this.authorId,
    required this.createdAt,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    final createdAtRaw = json['created_at'];

    return Article(
      id: json['id'] as String,
      title: (json['title'] ?? '') as String,
      content: (json['content'] ?? '') as String,
      category: (json['category'] ?? '') as String,
      coverUrl: json['cover_url'] as String?,
      sourceUrl: json['source_url'] as String?,
      authorId: json['author_id'] as String?,
      createdAt: createdAtRaw == null
          ? null
          : DateTime.parse(createdAtRaw as String),
    );
  }
}
