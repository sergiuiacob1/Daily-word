import 'package:flutter/material.dart';
import 'page_utils.dart' as PageUtils;
import '../blocs/favorites_bloc.dart';
import '../providers/favorites_provider.dart';

class FavoritesUI extends StatelessWidget {
  final title = "Favorites";

  @override
  Widget build(BuildContext context) {
    FavoritesBloc favoritesBloc = FavoritesProvider.of(context);
    return new CustomScrollView(
      key: PageStorageKey("FavoritesUIScroll"),
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        PageUtils.buildSliverAppBar(context, title),
        _buildContent(favoritesBloc),
      ],
    );
  }

  Widget _buildContent(FavoritesBloc favoritesBloc) {
    return StreamBuilder(
        stream: favoritesBloc.favoriteWords,
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0) {
            return SliverFillRemaining(
              child: Center(
                child: Text(
                  "Your favorite words will appear here",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.title.fontSize,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          return SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, i) {
                if (i % 2 == 0)
                  return PageUtils.buildWordWidget(
                      context, snapshot.data[i ~/ 2]);
                return Divider(
                  height: 32.0,
                );
              },
              childCount: snapshot.data.length * 2 - 1,
            ),
          );
        });
  }
}
