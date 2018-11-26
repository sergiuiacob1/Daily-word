import 'words_storage_bloc.dart';
import 'package:rxdart/rxdart.dart';

class FavoritesBloc {
  WordsStorageBloc _storageBloc = WordsStorageBloc();

  BehaviorSubject get favoriteWords => _storageBloc.favoriteWordsStream;
}
