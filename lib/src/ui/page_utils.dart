import 'package:flutter/material.dart';
import './../models/word.dart';

Widget buildWordWidget(BuildContext context, Word word) {
  return Container(
    padding: EdgeInsets.all(8.0),
    width: MediaQuery.of(context).size.width,
    // height: MediaQuery.of(context).size.height / 8,
    margin: EdgeInsets.all(8.0),
    child: Row(
      children: <Widget>[
        Image(
          image: word.language.icon,
          width: 64.0,
          height: 64.0,
        ),
        Expanded(
          flex: 2,
          child: Container(
            padding: EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: <Widget>[
                Text(
                  word.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline.fontSize),
                ),
                Divider(),
                Text(
                  word.definitions[word.definitions.keys.first][0],
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.subhead.fontSize),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      iconSize: 32.0,
                      icon: Icon(Icons.volume_up),
                      onPressed: speakWord(word),
                    ),
                    IconButton(
                      iconSize: 32.0,
                      icon: Icon(Icons.favorite_border),
                      onPressed: null,
                    ),
                    FlatButton(
                      child: const Text('More...'),
                      color: Theme.of(context).primaryColor,
                      splashColor: word.language.color,
                      onPressed: () {
                        // Perform some action
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

void speakWord(Word word){
  
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
