class Space {
  final String id;
  final String title;
  final String author;
  final String? imageUrl;
  final String? url;
  final String? summary;
  final String? news_site;
  final DateTime? publishedAt;
  final String? updatedAt;
  final List<dynamic>? launches;
  final List<dynamic>? events;

  Space({
    required this.id,
    required this.title,
    required this.author,
    required this.imageUrl,
    required this.url,
    required this.news_site,
    required this.summary,
    required this.publishedAt,
    required this.updatedAt,
    required this.launches,
    required this.events,
  });
  factory Space.fromJsonSimple(Map<String, dynamic> json) {
    return Space(
      id: json['idspace'].toString(),
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      imageUrl: json['imageUrl'] ?? '', 
      url: json['url'] ?? '',
      news_site: json['news_site'] ?? '',
      summary: json['summary'] ?? '',
      publishedAt: DateTime.tryParse(json['publishedAt'] ?? ''),
      updatedAt: json['updatedAt'] ?? '',
      launches: json['launches'] ?? [],
      events: json['events'] ?? [],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'idspace': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'url': url,
      'news_site': news_site,
      'summary': summary,
      'publishedAt': publishedAt?.toIso8601String(),
      'updatedAt': updatedAt,
      'launches': launches,
      'events': events,
    };
  }
}
