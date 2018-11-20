import 'package:flutter/material.dart';
import 'page_utils.dart' as PageUtils;
import '../blocs/dictionary_bloc.dart';
import '../providers/dictionary_provider.dart';

class DictionaryUI extends StatelessWidget {
  final title = "Dictionary";
  final Widget content = null;

  @override
  Widget build(BuildContext context) {
    DictionaryBloc dictionaryBloc = DictionaryProvider.of(context);
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        _buildSliverAppBar(),
        // _buildSearchBar(dictionaryBloc),
        _buildContent(dictionaryBloc),
        // content,
        SliverFillRemaining(
          child: Container(
            color: Colors.redAccent,
          ),
        ),
      ],
    );
  }

  Widget _buildContent(DictionaryBloc dictionaryBloc) {
    List<Widget> _children = [];
    _children.add(_buildSearchBar(dictionaryBloc));
    return SliverList(
      delegate: SliverChildListDelegate(_children),
    );
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
