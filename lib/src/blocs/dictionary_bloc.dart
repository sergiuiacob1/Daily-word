import 'package:rxdart/rxdart.dart';
import 'api_bloc.dart';
import './words_storage_bloc.dart';

class DictionaryBloc {
  final ApiBloc apiBloc = ApiBloc();
  ReplaySubject<String> _query = ReplaySubject<String>();
  BehaviorSubject _searchResults = BehaviorSubject(seedValue: []);
  DictionaryBloc() {
    _query.distinct().listen(apiBloc.searchForWord);
    apiBloc.wordsStream.listen((data) => _searchResults.add(data));
    _listenToFavoriteStatusChanges();
  }

  void _listenToFavoriteStatusChanges() async {
    WordsStorageBloc().favoriteWordsStream.listen((onData) {
      dynamic _lastSearchResults = apiBloc.wordsStream.value;
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
    _query.sink.add(query);
  }

  BehaviorSubject get results => _searchResults;
}
