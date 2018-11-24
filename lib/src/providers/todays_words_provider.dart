import 'package:flutter/material.dart';
import './../blocs/todays_words_bloc.dart';
import '../ui/todays_words_ui.dart';

class TodaysWordsProvider extends InheritedWidget {
  final TodaysWordsBloc todaysWordsBloc = TodaysWordsBloc();

  TodaysWordsProvider({
    Key key,
  }) : super(key: key, child: TodaysWordsUI());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static TodaysWordsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(TodaysWordsProvider)
              as TodaysWordsProvider)
          .todaysWordsBloc;
}
