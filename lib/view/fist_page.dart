import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/data/data.dart' as globals;

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState
    _setThemeMode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Image.asset(
        Provider.of<ProviderTheme>(context).themeMode == 'dark'
            ? 'Assets/Images/crossDark.png'
            : 'Assets/Images/crossLight.png',
        height: 250,
        width: 250,
      ),
    );
  }

  Future<void> _setThemeMode() async {

    await Provider.of<ProviderTheme>(context, listen: false)
        .setInitThemeMode(context);

    if (mounted) {
      await Provider.of<ProviderLanguage>(context, listen: false)
          .setInitLanguage();
    }

    await _goHome();
  }

  Future<void> _goHome() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/MainPage', (route) => false);
    }
  }
}
