import 'package:flutter/material.dart';
import 'package:treex_app/Utils/brightnessUtil.dart';

class AppSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.search), onPressed: () {}),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
@override
  String get searchFieldLabel => '搜索';
  @override
  ThemeData appBarTheme(BuildContext context) {
    return isDark(context)
        ? ThemeData.dark().copyWith(
            inputDecorationTheme: InputDecorationTheme(
              fillColor: Colors.pinkAccent,
              filled: true,
            ),
          )
        : ThemeData.light();
  }
}
