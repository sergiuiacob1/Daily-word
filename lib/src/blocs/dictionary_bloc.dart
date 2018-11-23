import 'package:rxdart/rxdart.dart';
import '../models/word.dart';
import '../models/api.dart';

class DictionaryBloc {
  final Api api = Api();
  ReplaySubject<String> _query = ReplaySubject<String>();
  Stream<List<Word>> _results = Stream.empty();

  DictionaryBloc() {
    _results = api.wordsObservable;
    _query.distinct().listen(api.handleSearch);
  }

  void dispose() {
    _query.close();
  }

  void handleSearch(String query) {
    print('Searching: $query');
    _query.sink.add(query);
  }

  Stream<List<Word>> get results => _results;
}
