import 'package:flutter/material.dart';
import '../services/serie_api_service.dart';
import '../models/serie.dart';

class SerieProvider with ChangeNotifier {
    final SerieApiService _apiService = SerieApiService();

    List<Serie> _series = [];
    bool _isLoading = false;
    String? _error;
    

    List<Serie> get series => _series;
    bool get isLoading => _isLoading;
    String? get error => _error;

    Future<void> fetchSeries() async {
        _isLoading = true;
        _error = null;
        try {
            _series = await _apiService.fetchSeries();
        } catch (e) {
            _error = 'Impossible de charger les series.'
            _series = _apiService.getMockSeries();
        } finally {
            _isLoading = false;
            notifyListeners();
        }
    }
    Future<Serie> fetchSerieById (int id) async {
        return _apiService.fetchSerieById(id);
    }
}