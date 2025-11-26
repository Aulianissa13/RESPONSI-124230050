class Category {
  final String id;
  final String title;
  final String thumbnail;
  final String description;

  Category({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['idCategory'] ?? '',
      title: json['strCategory'] ?? '',
      thumbnail: json['strCategoryThumb'] ?? '',
      description: json['strCategoryDescription'] ?? '',
    );
  }
}