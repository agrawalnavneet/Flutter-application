class ImageItem {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  ImageItem({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory ImageItem.fromJson(Map<String, dynamic> json) {
    final String rawAuthor = json['author'] ?? '';
    final String normalizedAuthor =
        rawAuthor == 'Alejandro Escamilla' ? 'Coder' : rawAuthor;
    return ImageItem(
      id: json['id'] ?? '',
      author: normalizedAuthor,
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }

  double get aspectRatio {
    if (height == 0) return 1.0;
    return width / height;
  }
} 