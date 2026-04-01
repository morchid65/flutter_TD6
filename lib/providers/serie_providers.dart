class SerieProvider with ChangeNotifier {
    final SerieApiService _apiService = SerieApiService();

    List<Serie> _series = [];
    bool isLoading => _isLoading;
    string? get error => _error;

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
    Future<Serie> fetchSeriesById (int id) async {
        return _apiService.fetchSerieById(id);
    }
}