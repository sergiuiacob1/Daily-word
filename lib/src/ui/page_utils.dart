import 'package:flutter/material.dart';
import './../models/word.dart';
import './../models/language.dart';

  Widget buildWordWidget(BuildContext context, Word word) {
    return new Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 5,
      decoration: new BoxDecoration(
        border: new Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.all(
          Radius.elliptical(16.0, 16.0),
        ),
      ),
      margin: EdgeInsets.all(8.0),
      child: new ListTile(
        leading: Icon(word.language.icon),
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Icon(Icons.language),
            new Text(
              word.name,
              style: TextStyle(
                  fontSize: Theme.of(context).textTheme.headline.fontSize),
            ),
            IconButton(
              icon: new Icon(
                  word.isFavorite ? Icons.favorite : Icons.favorite_border),
              tooltip: 'Add to favorites',
              onPressed: null,
            )
          ],
        ),
        subtitle: new Column(
          children: <Widget>[
            new Divider(),
            new Text(
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
  return new SliverAppBar(
    expandedHeight: 200.0,
    pinned: true,
    flexibleSpace: new FlexibleSpaceBar(
      title: new Text(
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
  List<Widget> _list = [new Center(child: new Text(_text))];
  return new SliverList(
    delegate: new SliverChildListDelegate(
      _list,
    ),
  );
}
