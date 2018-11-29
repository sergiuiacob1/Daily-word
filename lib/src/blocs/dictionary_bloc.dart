import 'package:rxdart/rxdart.dart';
import 'internet_results_bloc.dart';
import './words_storage_bloc.dart';

class DictionaryBloc {
  final InternetResultsBloc _internetResultsBloc = InternetResultsBloc();
  ReplaySubject<String> _query = ReplaySubject<String>();
  BehaviorSubject _searchResults = BehaviorSubject(seedValue: []);
  DictionaryBloc() {
    _query.distinct().listen(_internetResultsBloc.searchForWord);
    _internetResultsBloc.wordsStream.listen((data) => _searchResults.add(data));
    _listenToFavoriteStatusChanges();
  }

  void _listenToFavoriteStatusChanges() async {
    WordsStorageBloc().favoriteWordsStream.listen((onData) {
      dynamic _lastSearchResults = _internetResultsBloc.wordsStream.value;
      for (var i = 0; i < _lastSearchResults.length; ++i)
        if (onData
                .where((_favWord) =>
                    _favWord.name == _lastSearchResults[i].name &&
                    _favWord.language == _lastSearchResults[i].language)
                .length >
            0)
          _lastSearchResults[i].isFavorite = true;
        else
          _lastSearchResults[i].isFavorite = false;
      _searchResults.add(_lastSearchResults);
    });
  }

  void dispose() {
    _query.close();
  }

  void handleSearch(String query) async {
    _query.sink.add(_format(query));
  }

  String _format (String _toFormat){
    return _toFormat.trim();
  }

  BehaviorSubject get results => _searchResults;

  bool get isStillSearching => _internetResultsBloc.isStillSearching;
}
