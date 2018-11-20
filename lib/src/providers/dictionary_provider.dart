import 'package:flutter/material.dart';
import './../blocs/dictionary_bloc.dart';
import '../blocs/dictionary_bloc.dart';
import '../ui/dictionary_ui.dart';

class DictionaryProvider extends InheritedWidget {
  final DictionaryBloc dictionaryBloc = DictionaryBloc();

  DictionaryProvider({
    Key key,
  }) : super(key: key, child: DictionaryUI());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DictionaryBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(DictionaryProvider)
              as DictionaryProvider)
          .dictionaryBloc;
}
