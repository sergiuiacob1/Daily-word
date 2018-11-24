import 'dart:async';

class TodaysWordsBloc {
  Stream _words = Stream.empty();
  // WordsStorageBloc _storageBloc = WordsStorageBloc();

  TodaysWordsBloc() {
// _words = _storageBloc.
  }

  Stream<dynamic> get words => _words;
}
