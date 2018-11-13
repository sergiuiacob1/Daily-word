import 'package:flutter/material.dart';

class DoubleHolder {
  double value = 0.0;
}

Widget buildSliverAppBar(String title) {
  return new SliverAppBar(
    expandedHeight: 200.0,
    pinned: true,
    flexibleSpace: new FlexibleSpaceBar(
      title: new Text(title),
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
          if (snapshot.hasError)
            return _sliverListPlaceholder('Error: ${snapshot.error}');
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
