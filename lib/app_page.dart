import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DoubleHolder {
  double value = 0.0;
}

class AppPage extends StatefulWidget {
  final String title;
  final Widget content;
  final DoubleHolder scrollOffset = new DoubleHolder();

  AppPage({Key key, @required this.title, @required this.content})
      : assert(title != null),
        assert(content != null),
        super(key: key);

  double getScrollOffset() {
    return scrollOffset.value;
  }

  void setScrollOffset(double _aux) {
    scrollOffset.value = _aux;
  }

  @override
  _AppPageState createState() => new _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController =
        new ScrollController(initialScrollOffset: widget.getScrollOffset());
    return new NotificationListener(
      child: new CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          _buildSliverAppBar(),
          widget.content,
        ],
      ),
      onNotification: (notification) {
        if (notification is ScrollNotification) {
          widget.setScrollOffset(notification.metrics.pixels);
        }
      },
    );
  }

  Widget _buildSliverAppBar() {
    return new SliverAppBar(
      expandedHeight: 200.0,
      pinned: true,
      flexibleSpace: new FlexibleSpaceBar(
        title: new Text(widget.title),
      ),
    );
  }
}
