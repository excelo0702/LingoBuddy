class Word {
  final int id;
  final String word;
  final String translation;
  final String pronunciation;
  final String imageUrl;

  Word({
    required this.id,
    required this.word,
    required this.translation,
    required this.pronunciation,
    required this.imageUrl,
  });

  factory Word.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];
    final imageUrl = attributes['image']?['data']?['attributes']?['url'] ?? '';
    return Word(
      id: json['id'],
      word: attributes['word'] ?? 'No word',
      translation: attributes['translation'] ?? 'No translation',
      pronunciation: attributes['pronunciation'] ?? 'No pronunciation',
      imageUrl: 'http://localhost:1337$imageUrl',
    );
  }
}
