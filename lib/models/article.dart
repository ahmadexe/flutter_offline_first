import 'dart:convert';

class Article {
  final String title;
  final String description;
  final String content;
  final String url;
  final String urlToImage;
  final int? isSynced;
  Article({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.urlToImage,
    this.isSynced = 1,
  });

  Article copyWith({
    String? title,
    String? description,
    String? content,
    String? url,
    String? urlToImage,
    int? isSynced,
  }) {
    return Article(
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      isSynced: isSynced?? this.isSynced,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'urlToImage': urlToImage,
      'isSynced': isSynced,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      title: map['title'] as String,
      description: map['description'] as String,
      content: map['content'] as String,
      url: map['url'] as String,
      urlToImage: map['urlToImage'] as String,
      isSynced: map['isSynced'] ?? 1,
    );
  }

  String toJson() => json.encode(toMap());

  factory Article.fromJson(String source) =>
      Article.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Article(title: $title, description: $description, content: $content, url: $url, urlToImage: $urlToImage, isSynced: $isSynced,)';
  }

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.description == description &&
        other.content == content &&
        other.url == url &&
        other.urlToImage == urlToImage &&
        other.isSynced == isSynced;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        content.hashCode ^
        url.hashCode ^
        urlToImage.hashCode ^
        isSynced.hashCode;
  }
}
