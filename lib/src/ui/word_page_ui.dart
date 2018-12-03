import 'package:flutter/material.dart';
import './../models/word.dart';
import './../providers/word_page_provider.dart';
import './../blocs/word_page_bloc.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class WordPageUI extends StatelessWidget {
  final Word word;

  WordPageUI({Key key, @required this.word}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WordPageBloc bloc = WordPageProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          word.name.toUpperCase(),
          style: TextStyle(
            fontSize: Theme.of(context).textTheme.headline.fontSize,
          ),
        ),
        actions: <Widget>[
          Image(
            image: word.language.icon,
            width: 32.0,
            height: 32.0,
          ),
          Padding(
            padding: EdgeInsets.only(right: 16.0),
          )
        ],
      ),
      body: CustomScrollView(
        slivers: _buildContent(context, bloc),
      ),
    );
  }

  List<Widget> _buildContent(BuildContext context, WordPageBloc bloc) {
    List<Widget> _content = [];
    for (var _defType in word.definitions.keys) {
      _content.add(
        new SliverStickyHeader(
          header: new Container(
            margin: EdgeInsets.only(bottom: 16.0),
            color: Theme.of(context).accentColor,
            padding: EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              "    " + _defType,
              style: TextStyle(
                color: Colors.white,
                fontSize: Theme.of(context).textTheme.title.fontSize,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
              (context, i) {
                if (i % 2 == 0)
                  return Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      "    " + word.definitions[_defType][i ~/ 2],
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.body2.fontSize,
                      ),
                    ),
                  );
                if (i == word.definitions[_defType].length * 2 - 1)
                  return Padding(
                    padding: EdgeInsets.only(bottom: 32.0),
                  );
                return Divider(
                  height: 32.0,
                );
              },
              childCount: word.definitions[_defType].length * 2,
            ),
          ),
        ),
      );
    }

    return _content;
  }
}
