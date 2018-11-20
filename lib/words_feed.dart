// import 'package:flutter/material.dart';
// import 'page_utils.dart' as PageUtils;
// import 'words_feed_storage.dart';
// import 'word.dart';
// // import 'api.dart';
// // import 'romanian_dictionary_api.dart';
// import 'english_dictionary_api.dart';

// class WordsFeed extends StatefulWidget {
//   final WordsFeedStorage wordsFeedStorage = new WordsFeedStorage();
//   final String title = "Words Feed";

//   WordsFeed() : super(key: PageStorageKey("WordsFeed"));

//   @override
//   State<StatefulWidget> createState() {
//     return new _WordsFeedState();
//   }
// }

// class _WordsFeedState extends State<WordsFeed> {
//   Future<Widget> content;
//   ScrollController _scrollController;

//   @override
//   void initState() {
//     super.initState();
//     print('Creating: ${widget.title}');
//     WidgetsBinding.instance.addPostFrameCallback(
//       (_) => setState(
//             () {
//               content =
//                   _buildContent(); // this uses context, so initState() must finish first
//             },
//           ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Build: ${widget.title}');
//     return new CustomScrollView(
//       controller: _scrollController,
//       scrollDirection: Axis.vertical,
//       slivers: <Widget>[
//         PageUtils.buildSliverAppBar(widget.title),
//         PageUtils.buildFutureContent(content),
//       ],
//     );
//   }

//   Future<Widget> _buildContent() async {
//     List<Widget> _words = await _buildWords();
//     return new SliverList(
//       delegate: new SliverChildListDelegate(
//         _words,
//       ),
//     );
//   }

//   Future<List<Widget>> _buildWords() async {
//     List<Widget> _widgets = [];
//     List<Word> _words = [];
//     // List<Word> _words = await Api.getDailyWords();
//     // List<Word> _words = await widget.wordsFeedStorage.getWordsFromStorage();
//     _widgets.add(_buildWordWidget(await EnglishDictionaryApi.getDailyWord()));
//     for (Word _word in _words) {
//       _widgets.add(
//         _buildWordWidget(_word),
//       );
//     }
//     return _widgets;
//   }

//   Widget _buildWordWidget(Word word) {
//     return new Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height / 5,
//       decoration: new BoxDecoration(
//         border: new Border.all(color: Theme.of(context).primaryColor),
//         borderRadius: BorderRadius.all(
//           Radius.elliptical(16.0, 16.0),
//         ),
//       ),
//       margin: EdgeInsets.all(8.0),
//       child: new ListTile(
//         title: new Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             new Icon(Icons.language),
//             new Text(
//               word.name,
//               style: TextStyle(
//                   fontSize: Theme.of(context).textTheme.headline.fontSize),
//             ),
//             IconButton(
//               icon: new Icon(
//                   word.isFavorite ? Icons.favorite : Icons.favorite_border),
//               tooltip: 'Add to favorites',
//               onPressed: null,
//             )
//           ],
//         ),
//         subtitle: new Column(
//           children: <Widget>[
//             new Divider(),
//             new Text(
//               'No Definition',
//               style: TextStyle(
//                   fontSize: Theme.of(context).textTheme.subhead.fontSize),
//               textAlign: TextAlign.center,
//               // maxLines: 3,
//               // overflow: TextOverflow.ellipsis,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
