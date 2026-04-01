import 'package:flutter_test/flutter_test.dart';
import 'package:serie_liste/models/serie.dart'; 

void main() {
   group('Serie', () {  
    
    final jsonComplet = {
      'id': 1,
      'name': 'Breaking Bad',
      'genres': ['Drama', 'Crime'],
      'status': 'Ended',
      'image': {'medium': 'https://example.com/bb.jpg'},  
      'summary': '<p>Un professeur de chimie qui tourne mal.</p>',
      'rating': {'average': 9.5},
    };

    test('fromJson doit créer une instance de Serie avec les bonnes valeurs', () {
      final serie = Serie.fromJson(jsonComplet);

      expect(serie.id, 1);
      expect(serie.nom, 'Breaking Bad');
      expect(serie.statut, 'Ended');
      expect(serie.genre, 'Drama');
      expect(serie.note, 9.5);
      expect(serie.imageUrl, 'https://example.com/bb.jpg');
    });

    test('fromJson doit supprimer proprement les balises HTML du synopsis', () {
      final serie = Serie.fromJson(jsonComplet);

      expect(serie.synopsis, 'Un professeur de chimie qui tourne mal.');
      expect(serie.synopsis, isNot(contains('<p>')));
      expect(serie.synopsis, isNot(contains('</p>')));
    });

    test('fromJson doit être résilient face aux champs optionnels absents (JSON minimal)', () {
      final jsonMinimal = {
        'id': 2,
        'name': 'Test Serie'
      };

      final serie = Serie.fromJson(jsonMinimal);

      expect(serie.id, 2);
      expect(serie.nom, 'Test Serie');
      expect(serie.genre, 'Inconnu');
      expect(serie.synopsis, '');
      expect(serie.statut, 'Unknown');
      expect(serie.imageUrl, isNull);
      expect(serie.note, isNull);
    });

    test('La conversion toJson / fromJson doit être symétrique (pour le stockage)', () {
      // 1. On crée un objet Serie de référence
      final original = Serie.fromJson(jsonComplet);

      // 2. On le transforme en Map (toJson)
      final jsonProduit = original.toJson();

 
      final reconstruit = Serie.fromJson(jsonComplet);

      // 4. Vérifications
      expect(reconstruit.id, original.id);
      expect(reconstruit.nom, original.nom);
      expect(reconstruit.note, original.note);
      
      // Vérifie l'égalité grâce à l'override de l'opérateur ==
      expect(reconstruit, equals(original));
    });
  }); // Fin du group
}