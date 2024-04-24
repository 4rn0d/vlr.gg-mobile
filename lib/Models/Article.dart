class Article {
  final String title;
  final String description;
  final String date;
  final String author;
  final String urlPath;

  const Article({
    required this.title,
    required this.description,
    required this.date,
    required this.author,
    required this.urlPath
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'title': String title,
      'description': String description,
      'date': String date,
      'author': String author,
      'urlPath': String urlPath,
      } =>
          Article(
            title: title,
            description: description,
            date: date,
            author: author,
            urlPath: urlPath,
          ),
      _ => throw const FormatException('Failed to load article.'),
    };
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    data['date'] = date;
    data['author'] = author;
    data['urlPath'] = urlPath;
    return data;
  }
}