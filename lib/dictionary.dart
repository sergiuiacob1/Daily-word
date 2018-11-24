// import 'package:flutter/material.dart';
// import 'page_utils.dart' as PageUtils;

// class Dictionary extends StatefulWidget {
//   final String title = "Dictionary";

//   Dictionary() : super(key: PageStorageKey("Dictionary"));

//   @override
//   State<StatefulWidget> createState() {
//     return new _DictionaryState();
//   }
// }

// class _DictionaryState extends State<Dictionary> {
//   Widget content;

//   @override
//   void initState() {
//     super.initState();
//     content = _buildContent();
//     print('Creating: ${widget.title}');
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Build: ${widget.title}');
//     return new CustomScrollView(
//       key: PageStorageKey("Dictionary"),
//       scrollDirection: Axis.vertical,
//       slivers: <Widget>[
//         PageUtils.buildSliverAppBar(widget.title),
//         content,
//       ],
//     );
//   }

//   Widget _buildContent() {
//     return new SliverList(
//       delegate: new SliverChildListDelegate(
//         buildTextViews(50),
//       ),
//     );
//   }

//   static List<Widget> buildTextViews(int count) {
//     List<Widget> strings = List();
//     for (int i = 0; i < count; i++) {
//       strings.add(new Center(
//           child: new Padding(
//               padding: new EdgeInsets.all(16.0),
//               child: new Text("Item number dictionary " + i.toString(),
//                   style: new TextStyle(fontSize: 20.0)))));
//     }
//     return strings;
//   }
// }
