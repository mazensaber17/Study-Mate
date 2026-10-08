class NewsModel {
  const NewsModel({
    this.title,
    this.description,
    this.category,
    this.publishedAt,
  });

  final String? title;
  final String? description;
  final String? category;
  final DateTime? publishedAt;
}
