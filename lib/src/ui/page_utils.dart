import 'package:flutter/material.dart';
import './../models/word.dart';
import '../providers/word_page_provider.dart';
import './../blocs/words_storage_bloc.dart';
// import 'package:tts/tts.dart';
// import 'package:flutter_tts/flutter_tts.dart';

Widget buildWordWidget(BuildContext context, Word word) {
  return Container(
    padding: EdgeInsets.all(8.0),
    width: MediaQuery.of(context).size.width,
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
                  word.name.toUpperCase(),
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize),
                ),
                Divider(),
                Text(
                  word.definitions.keys.length > 0
                      ? word.definitions[word.definitions.keys.first][0]
                      : 'No definitions',
                  style: TextStyle(
                      fontSize: Theme.of(context).textTheme.body1.fontSize),
                  textAlign: TextAlign.center,
                  maxLines: 2,
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
                      icon: Icon(
                        Icons.volume_up,
                        color: Theme.of(context).accentColor,
                      ),
                      onPressed: () => speakWord(word),
                    ),
                    IconButton(
                      iconSize: 32.0,
                      icon: Icon(
                        word.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: word.isFavorite
                            ? Colors.red
                            : Theme.of(context).accentColor,
                      ),
                      onPressed: () => _changeFavoriteStatus(word),
                    ),
                    FlatButton(
                      child: Text(
                        'More',
                        style: TextStyle(
                          fontSize: Theme.of(context).textTheme.body1.fontSize,
                        ),
                      ),
                      textTheme: ButtonTextTheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Theme.of(context).accentColor,
                      splashColor: Theme.of(context).primaryColor,
                      onPressed: () => _openWordPage(context, word),
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

void _changeFavoriteStatus(Word word) {
  WordsStorageBloc _storageBloc = WordsStorageBloc();
  _storageBloc.changeFavoriteStatus(word);
}

void _openWordPage(BuildContext context, Word word) {
  Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => WordPageProvider(word: word)));
}

void speakWord(Word word) async {
  // Tts.speak('hello');
  // FlutterTts flutterTts = new FlutterTts();
  // try {
  //   flutterTts.speak("Hello World");
  // } catch (e) {
  //   print(e);
  // }
}

Widget buildSliverAppBar(BuildContext context, String title) {
  return SliverAppBar(
    // backgroundColor: Colors.transparent,
    expandedHeight: 250.0,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
      centerTitle: true,
      background: Container(
        decoration: BoxDecoration(
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.elliptical(64.0, 32.0),
            //   bottomRight: Radius.elliptical(64.0, 32.0),
            // ),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   stops: [0.0, 0.5, 1.0],
            //   // colors: [Colors.blue, Colors.blue]
            //   colors: [
            //     const Color(0xFF2B32B2),
            //     const Color(0xFF1488CC),
            //     const Color(0xFF2B32B2),
            //   ],
            // ),
            ),
      ),
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: Theme.of(context).textTheme.headline.fontSize,
        ),
      ),
    ),
  );
}
