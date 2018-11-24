import 'package:flutter/material.dart';
import './../blocs/favorites_bloc.dart';
import './../ui/favorites_ui.dart';

class FavoritesProvider extends InheritedWidget {
  final FavoritesBloc favoritesBloc = FavoritesBloc();

  FavoritesProvider({
    Key key,
  }) : super(key: key, child: FavoritesUI());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static FavoritesBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(FavoritesProvider)
              as FavoritesProvider)
          .favoritesBloc;
}
