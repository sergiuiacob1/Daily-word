import 'package:flutter/material.dart';
import './../models/word.dart';
import './../models/language.dart';
import './page_utils.dart' as PageUtils;
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
        title: Text(word.name),
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
            height: 45.0,
            margin: EdgeInsets.only(bottom: 16.0),
            color: word.language.color,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              _defType,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30.0,
              ),
            ),
          ),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate((context, i) {
              if (i % 2 == 0) return Text(word.definitions[_defType][i ~/ 2]);
              return Divider(
                height: 32.0,
              );
            }, childCount: word.definitions[_defType].length * 2 - 1),
          ),
        ),
      );

      _content.add(
        SliverPadding(
          padding: EdgeInsets.only(bottom: 16.0),
        ),
      );
    }

    return _content;
  }
}
