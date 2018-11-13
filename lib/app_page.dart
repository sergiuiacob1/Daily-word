import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class DoubleHolder {
  double value = 0.0;
}

class AppPage extends StatefulWidget {
  final String title;
  final Future<Widget> content;
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
    print('Creating: $widget.title');
  }

  @override
  Widget build(BuildContext context) {
    print('Build: $widget.title');
    ScrollController _scrollController =
        new ScrollController(initialScrollOffset: widget.getScrollOffset());
    return new NotificationListener(
      child: new CustomScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          _buildSliverAppBar(),
          _buildFutureContent(),
        ],
      ),
      onNotification: (notification) {
        if (notification is ScrollNotification) {
          widget.setScrollOffset(notification.metrics.pixels);
        }
      },
    );
  }

  Widget _buildFutureContent() {
    return FutureBuilder<Widget>(
      future: widget.content,
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
