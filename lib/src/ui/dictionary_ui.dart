import 'package:flutter/material.dart';
import 'page_utils.dart' as PageUtils;
import '../blocs/dictionary_bloc.dart';
import '../providers/dictionary_provider.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class DictionaryUI extends StatelessWidget {
  final title = "Dictionary";

  @override
  Widget build(BuildContext context) {
    DictionaryBloc dictionaryBloc = DictionaryProvider.of(context);
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        _buildSliverAppBar(),
        _buildContent(dictionaryBloc),
      ],
    );
  }

  Widget _buildContent(DictionaryBloc dictionaryBloc) {
    return SliverStickyHeader(
      header: _buildSearchBar(dictionaryBloc),
      sliver: _buildSearchResults(dictionaryBloc),
    );
  }

  Widget _buildSearchResults(DictionaryBloc dictionaryBloc) {
    return StreamBuilder(
        stream: dictionaryBloc.results,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data.length == 0)
            return SliverFillRemaining(
              child: Container(
                color: Colors.yellow[100],
              ),
            );

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

  Widget _buildSearchBar(DictionaryBloc dictionaryBloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Flexible(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Cauta',
            ),
            onChanged: dictionaryBloc.handleSearch,
          ),
        ),
        Icon(
          Icons.search,
        ),
      ],
    );
  }

  Widget _buildSliverAppBar() {
    return new SliverAppBar(
      expandedHeight: 300.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        title: Text("Dictionary"),
      ),
    );
  }
}
