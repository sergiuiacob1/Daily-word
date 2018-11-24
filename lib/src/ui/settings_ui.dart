import 'package:flutter/material.dart';
import 'page_utils.dart' as PageUtils;
import '../blocs/settings_bloc.dart';
import '../providers/settings_provider.dart';

class SettingsUI extends StatelessWidget {
  final title = "SettingsUI";

  @override
  Widget build(BuildContext context) {
    SettingsBloc settingsBloc = SettingsProvider.of(context);
    return new CustomScrollView(
      scrollDirection: Axis.vertical,
      slivers: <Widget>[
        PageUtils.buildSliverAppBar(title),
        _buildContent(settingsBloc),
      ],
    );
  }

  Widget _buildContent(SettingsBloc settingsBloc) {
    return SliverFillRemaining(
      child: Container(
        color: Colors.red[100],
      ),
    );
  }
}

// class Settings extends StatefulWidget {
//   final String title = "Settings";

//   Settings({Key key}) : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return new _SettingsState();
//   }
// }

// class _SettingsState extends State<Settings> {
//   SharedPreferences pref;
//   List<String> selectedLanguages;

//   @override
//   void initState() {
//     super.initState();
//     selectedLanguages = [];
//     _buildSelectedLanguages();
//     print('Creating: $widget.title');
//   }

//   void _buildSelectedLanguages() async {
//     pref = await SharedPreferences.getInstance();
//     setState(() {
//       selectedLanguages = pref.getStringList("SelectedLanguages") ?? [];
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     print('Build: $widget.title');
//     return new CustomScrollView(
//       scrollDirection: Axis.vertical,
//       slivers: <Widget>[
//         PageUtils.buildSliverAppBar(widget.title),
//         _buildContent(),
//       ],
//     );
//   }

//   Widget _buildContent() {
//     return new SliverList(
//       delegate: new SliverChildListDelegate(
//         <Widget>[
//           _buildLanguageSelector(),
//         ],
//       ),
//     );
//   }

//   Widget _buildLanguageSelector() {
//     return ExpansionTile(
//       title: new Text("Language select"),
//       children: languages.values
//           .map((language) => CheckboxListTile(
//                 title: Text(language.name),
//                 value: _isLanguageSelected(language.name),
//                 onChanged: (value) => _languageCheck(language.name, value),
//               ))
//           .toList(),
//     );
//   }

//   void _languageCheck(String languageName, bool value) async {
//     print('Press $languageName: $value');
//     if (value)
//       selectedLanguages.add(languageName);
//     else
//       selectedLanguages.remove(languageName);

//     if (pref != null) {
//       await pref.setStringList("SelectedLanguages", selectedLanguages);
//       setState(() {});
//     }
//   }

//   bool _isLanguageSelected(String _languageName) {
//     print('Vector: $selectedLanguages');
//     return selectedLanguages.contains(_languageName);
//   }
// }
