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
    return CustomScrollView(
      key: PageStorageKey("DictionaryUIScroll"),
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        PageUtils.buildSliverAppBar(context, title),
        _buildContent(context, dictionaryBloc),
      ],
    );
  }

  Widget _buildContent(BuildContext context, DictionaryBloc dictionaryBloc) {
    return SliverStickyHeader(
      header: _buildSearchBar(context, dictionaryBloc),
      sliver: _buildSearchResults(dictionaryBloc),
    );
  }

  Widget _buildSearchResults(DictionaryBloc dictionaryBloc) {
    return StreamBuilder(
        stream: dictionaryBloc.results,
        builder: (context, snapshot) {
          // Nothing in the search field
          if (!snapshot.hasData) {
            return SliverFillRemaining(
              child: Center(
                child: Text("Write in the text field to search for words"),
              ),
            );
          }

          // search is done with no results
          if (snapshot.data.length == 0 && !dictionaryBloc.isStillSearching) {
            return SliverFillRemaining(
              child: Center(
                child: Text("No results"),
              ),
            );
          }

          // search results incoming
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                if (dictionaryBloc.isStillSearching) {
                  if (i == 0) return LinearProgressIndicator();
                  if (i % 2 == 1)
                    return PageUtils.buildWordWidget(
                        context, snapshot.data[(i - 1) ~/ 2]);
                  return Divider(
                    height: 32.0,
                  );
                } else {
                  if (i % 2 == 0)
                    return PageUtils.buildWordWidget(
                        context, snapshot.data[i ~/ 2]);
                  return Divider(
                    height: 32.0,
                  );
                }
              },
              childCount: snapshot.data.length == 0
                  ? 1
                  : snapshot.data.length * 2 -
                      1 +
                      (dictionaryBloc.isStillSearching == true ? 1 : 0),
            ),
          );
        });
  }

  Widget _buildSearchBar(BuildContext context, DictionaryBloc dictionaryBloc) {
    return TextField(
      cursorColor: Theme.of(context).accentColor,
      autocorrect: false,
      style: TextStyle(
        color: Colors.black,
        fontSize: Theme.of(context).textTheme.body2.fontSize,
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(20.0),
        border: UnderlineInputBorder(),
        hintText: 'Cauta un cuvant',
      ),
      onChanged: dictionaryBloc.handleSearch,
      onSubmitted: dictionaryBloc.handleSearch,
    );
  }
}
