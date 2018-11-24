import 'package:flutter/material.dart';
import './../models/word.dart';

Widget buildWordWidget(BuildContext context, Word word) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height / 10,
    margin: EdgeInsets.all(8.0),
    child: ListTile(
      leading: Column(
        children: <Widget>[
          Image(
            image: word.language.icon,
            width: 64.0,
            height: 64.0,
          ),
        ],
      ),
      title: Text(
        word.name,
        textAlign: TextAlign.center,
        style:
            TextStyle(fontSize: Theme.of(context).textTheme.headline.fontSize),
      ),
      subtitle: Column(
        children: <Widget>[
          Divider(),
          Text(
            'No Definition',
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.subhead.fontSize),
            textAlign: TextAlign.center,
            // maxLines: 3,
            // overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    ),
  );
}

Widget buildSliverAppBar(String title) {
  return SliverAppBar(
    expandedHeight: 300.0,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        title,
      ),
    ),
  );
}

Widget buildFutureContent(Future<Widget> content) {
  return FutureBuilder<Widget>(
    future: content,
    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
      switch (snapshot.connectionState) {
        case ConnectionState.none:
          return _sliverListPlaceholder('Waiting...');
        case ConnectionState.active:
        case ConnectionState.waiting:
          return _sliverListPlaceholder('Waiting...');
        case ConnectionState.done:
          if (snapshot.hasError) {
            print(snapshot.error);
            return _sliverListPlaceholder('Error: ${snapshot.error}');
          }
          return snapshot.data;
      }
      return null; // unreachable
    },
  );
}

SliverList _sliverListPlaceholder(String _text) {
  List<Widget> _list = [Center(child: Text(_text))];
  return SliverList(
    delegate: SliverChildListDelegate(
      _list,
    ),
  );
}
