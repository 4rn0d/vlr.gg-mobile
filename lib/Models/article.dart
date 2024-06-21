class Article {
  final int id;
  final String title;
  final String description;
  final String date;
  final String author;
  final String urlPath;

  Article({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.author,
    required this.urlPath
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'title': String title,
      'description': String description,
      'date': String date,
      'author': String author,
      'urlPath': String urlPath,
      } =>
          Article(
            id: id,
            title: title,
            description: description,
            date: date,
            author: author,
            urlPath: urlPath,
          ),
      _ => throw const FormatException('Failed to load article.'),
    };
  }

}