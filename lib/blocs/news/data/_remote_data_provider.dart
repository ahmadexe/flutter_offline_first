part of '../bloc.dart';

class _RemoteDataProvider {
  final _client = http.Client();
  final _firestore = FirebaseFirestore.instance;

  Future<List<Article>> getArticles() async {
    try {
      final key = dotenv.env['NEWS_API_KEY'];

      if (key == null || key.isEmpty) {
        throw Exception('API key not found');
      }

      final url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$key';

      List<Article> articles = [];
      var uri = Uri.parse(url);
      var response = await _client.get(uri);
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        jsonData['articles'].forEach((json) {
          if (json['url'] != null &&
              json['urlToImage'] != null &&
              json['description'] != null &&
              json['content'] != null &&
              json['title'] != null) {
            Article article = Article.fromMap(json as Map<String, dynamic>);
            articles.add(article);
          }
        });
        return articles;
      } else {
        throw Exception('Failed to load post');
      }
    } catch (e) {
      debugPrint("Error in getArticles: ${e.toString()}");
      rethrow;
    }
  }

  Future<void> markFavourite(Article article) async {
    try {
      await _firestore.collection('favourite').add(article.toMap());
    } catch (e) {
      debugPrint("Error in markFavourite: ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Article>> getFavourites() async {
    try {
      final res = await _firestore.collection('favourite').get();
      List<Article> favourites = [];
      for (final doc in res.docs) {
        favourites.add(Article.fromMap(doc.data()));
      }

      return favourites;
    } catch (e) {
      debugPrint("Error in getFavourites: ${e.toString()}");
      rethrow;
    }
  }
}
