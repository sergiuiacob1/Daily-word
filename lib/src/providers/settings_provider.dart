import 'package:flutter/material.dart';
import './../blocs/settings_bloc.dart';
import '../blocs/settings_bloc.dart';
import '../ui/settings_ui.dart';

class SettingsProvider extends InheritedWidget {
  final SettingsBloc settingsBloc = SettingsBloc();

  SettingsProvider({
    Key key,
  }) : super(key: key, child: SettingsUI());

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static SettingsBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(SettingsProvider)
              as SettingsProvider)
          .settingsBloc;
}
