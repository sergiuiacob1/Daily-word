import 'package:flutter/material.dart';
import './../blocs/word_page_bloc.dart';
import './../ui/word_page_ui.dart';

class WordPageProvider extends InheritedWidget {
  final WordPageBloc bloc = WordPageBloc();
  WordPageProvider({Key key, @required word})
      : assert(word != null),
        super(key: key, child: WordPageUI(word: word));

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static WordPageBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(WordPageProvider)
              as WordPageProvider)
          .bloc;
}
