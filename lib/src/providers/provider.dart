import 'package:flutter/material.dart';
import './../blocs/bloc.dart';
import 'package:flutter/foundation.dart';

abstract class Provider extends InheritedWidget {
  final Bloc bloc;

  Provider({Key key, @required childUI, @required this.bloc})
      : super(key: key, child: childUI);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static Bloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(Provider)
              as Provider)
          .bloc;
}
