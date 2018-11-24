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
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        PageUtils.buildSliverAppBar(title),
        _buildContent(favoritesBloc),
      ],
    );
  }

  Widget _buildContent(FavoritesBloc favoritesBloc) {
    return SliverFillRemaining(
      child: Container(
        color: Colors.purple,
      ),
    );
  }
}
