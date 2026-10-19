class NewsModel {
  const NewsModel({
    required this.id,
    required this.title,
    required this.snippet,
    required this.url,
    required this.publishedAt,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      snippet: json['snippet'] as String? ?? '',
      url: json['url'] as String? ?? '',
      publishedAt: DateTime.tryParse(json['published_at'] as String? ?? ''),
    );
  }

  final String id;
  final String title;
  final String snippet;
  final String url;
  final DateTime? publishedAt;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'snippet': snippet,
      'url': url,
      'published_at': publishedAt?.toIso8601String(),
    };
  }
}
