import 'package:flutter/material.dart'; 
import 'package:flutter_test/flutter_test.dart'; 
import 'package:serie_liste/providers/serie_provider.dart'; 

void main() {
    TestWidgetsFlutterBinding.ensureInitialized();

    group('SerieProvider', {
        test('état initial : liste vide, pas de chargement', () {
            final provider = SerieProvider();
            expect(provider.series, isEmpty);
            expect(provider.isLoading, isFalse);
            expect(provider.error, isNull);
        });
        test('notifie les listeners quand fetchSeries est appelé', () async {
            final provider = SerieProvider();
            var notified = false;
            provider.addListener(() => notified = true);
            await provider.fetchSeries();
            await Future.dalayed(const Duration(milliseconds: 50));
            expect(notified, isTrue);
        });
    });
}