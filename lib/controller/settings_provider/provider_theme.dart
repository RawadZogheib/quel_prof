import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quel_prof/api/my_session.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;

class ProviderTheme extends ChangeNotifier {
  String _themeMode = 'dark'; //dark//light

  final ThemeData _lightTheme = ThemeData(
    primaryColor: my_colors.primaryLight,
    backgroundColor: my_colors.backgroundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: my_colors.selectedItemColorLight,
      backgroundColor: my_colors.backgroundNavigationBarColorLight,
    ),
    iconTheme: IconThemeData(
      color: my_colors.iconColorLight, //navigationBar
      size: 22,
    ),
  );
  final ThemeData _darkTheme = ThemeData(
    primaryColor: my_colors.primaryDark,
    backgroundColor: my_colors.backgroundDark,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: my_colors.selectedItemColorDark,
      backgroundColor: my_colors.backgroundNavigationBarColorDark,
    ),
    iconTheme: IconThemeData(
      color: my_colors.iconColorDark, //navigationBar
      size: 22,
    ),
  );

  String get themeMode => _themeMode;

  setThemeMode() {
    if (_themeMode == 'light') {
      _themeMode = 'dark';
      setSession('dark');
    } else {
      _themeMode = 'light';
      setSession('light');
    }
    notifyListeners();
  }

  // setInitThemeMode(String themeMode) {
  //   _themeMode = themeMode;
  //   notifyListeners();
  // }

  Future<void> setInitThemeMode(BuildContext context) async {
    try {
      if (await SessionManager().get('themeMode') == 'dark') {
        _themeMode = 'dark';
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: my_colors.backgroundDark,
        ));
        notifyListeners();
        return;
      }

      if (await SessionManager().get('themeMode') == 'light') {
        _themeMode = 'light';
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          systemNavigationBarColor: my_colors.backgroundLight,
        ));
        notifyListeners();
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  ThemeData getThemeMode() {
    if (_themeMode == 'dark') {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   systemNavigationBarColor: globals.brown2,
      // ));
      return _darkTheme;
    } else {
      // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      //   systemNavigationBarColor: globals.brown2,
      // ));
      return _lightTheme;
    }
  }

  Future<void> setSession(String themeMode) async {
    await SessionManager().set('themeMode', themeMode);
  }
}
