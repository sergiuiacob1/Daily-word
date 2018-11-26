import 'package:rxdart/rxdart.dart';
import 'words_storage_bloc.dart';

class TodaysWordsBloc {
  WordsStorageBloc _storageBloc = WordsStorageBloc();

  BehaviorSubject get todaysWords => _storageBloc.todaysWordsStream;
}
