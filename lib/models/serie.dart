class Serie {
  final int id;
  final String nom;
  final String synopsis;
  final String genre;
  final String? imageUrl;
  final double? note;
  final String statut;

  // Le constructeur doit être À L'INTÉRIEUR de la classe
  const Serie({
    required this.id,
    required this.nom,
    required this.synopsis,
    required this.genre,
    this.imageUrl,
    this.note,
    required this.statut,
  });

  // Fonction utilitaire pour nettoyer le HTML du 'summary' de TVMaze
  static String _stripHtml(String? html) {
    if (html == null) return '';
    return html.replaceAll(RegExp(r'<[^>]*>'), '').trim();
  }

  factory Serie.fromJson(Map<String, dynamic> json) {
    final genres = json['genres'] as List<dynamic>?;

    return Serie(
      id: json['id'] as int,
      nom: json['name'] as String? ?? json['nom'] as String? ?? 'Sans titre',
      
      // TVMaze utilise 'summary' (avec HTML), on nettoie si besoin
      synopsis: json['summary'] != null 
          ? _stripHtml(json['summary'] as String?) 
          : json['synopsis'] as String? ?? '', 

      // TVMaze utilise 'genres' (liste), on prend le premier élément
      genre: genres != null && genres.isNotEmpty 
          ? genres[0] as String 
          : json['genre'] as String? ?? 'Inconnu', 

      // TVMaze : json['image']['medium'] — ou 'imageUrl' directement
      imageUrl: json['image']?['medium'] as String? ?? json['imageUrl'] as String?, 

      // TVMaze : json['rating']['average'] — ou 'note' directement
      note: (json['rating']?['average'] as num?)?.toDouble() 
          ?? (json['note'] as num?)?.toDouble(), 

      statut: json['status'] as String? ?? json['statut'] as String? ?? 'Unknown', 
    ); 
  }

  Map<String, dynamic> toJson() => { 
    'id': id, 
    'nom': nom, 
    'synopsis': synopsis, 
    'genre': genre, 
    'imageUrl': imageUrl, 
    'note': note, 
    'statut': statut, 
  }; 

  @override 
  bool operator ==(Object other) => other is Serie && other.id == id; 

  @override 
  int get hashCode => id.hashCode; 
}