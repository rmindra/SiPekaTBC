import 'package:sipekatbc/service/supabase_client.dart';

import 'models/article_model.dart';

class ArticleRepository {
  final _client = supabase;

  Future<List<Article>> fetchArticles({int? limit, int? offset}) async {
    final query = _client
        .from('articles')
        .select()
        .order('created_at', ascending: false);

    final res = limit == null
        ? await query
        : await query.range(offset ?? 0, (offset ?? 0) + limit - 1);

    return (res as List)
        .map((row) => Article.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  Future<Article> fetchArticleById(String articleId) async {
    final res = await _client
        .from('articles')
        .select()
        .eq('id', articleId)
        .single();

    return Article.fromJson(res);
  }

  Future<Article> createArticle({
    required String title,
    required String content,
    required String category,
    String? coverUrl,
    String? sourceUrl,
  }) async {
    final user = _client.auth.currentUser;
    final payload = <String, dynamic>{
      'title': title,
      'content': content,
      'category': category,
      'cover_url': coverUrl,
      'source_url': sourceUrl,
      'author_id': user?.id,
    };

    final res = await _client
        .from('articles')
        .insert(payload)
        .select()
        .single();

    return Article.fromJson(res);
  }

  Future<Map<String, int>> fetchReadingProgressMap() async {
    final user = _client.auth.currentUser;

    if (user == null) {
      return {};
    }

    final res = await _client
        .from('reading_history')
        .select('article_id, progress')
        .eq('user_id', user.id);

    final map = <String, int>{};

    for (final row in res as List) {
      final data = row as Map<String, dynamic>;
      final articleId = data['article_id'] as String?;
      final progress = data['progress'] as int?;

      if (articleId != null) {
        map[articleId] = progress ?? 0;
      }
    }

    return map;
  }

  Future<void> markRead(String articleId) async {
    final user = _client.auth.currentUser;

    if (user == null) {
      return;
    }

    await _client.from('reading_history').upsert({
      'user_id': user.id,
      'article_id': articleId,
      'progress': 1,
      'last_read_at': DateTime.now().toIso8601String(),
    }, onConflict: 'user_id,article_id');
  }
}
