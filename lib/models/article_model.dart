class Article {
  final String title;
  final String content;
  final String imageUrl;
  final String publishedDate;

  Article({
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.publishedDate,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'],
      content: json['content'],
      imageUrl: json['image_url'] ?? '',  // Caso não tenha a imagem, define como string vazia
      publishedDate: json['published_date'],
    );
  }
}
