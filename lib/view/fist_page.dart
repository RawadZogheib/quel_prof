import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/login/provider_login.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  @override
  void initState() {
    // TODO: implement initState
    _getPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).backgroundColor,
      alignment: Alignment.center,
      child: Image.asset(
        'Assets/launch_icon/167d298c-cef9-4317-b600-d8da249d4d2b.png',
        height: 250,
        width: 250,
      ),
    );
  }

  Future<void> _getPreferences() async {
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
      await Provider.of<ProviderLogin>(context, listen: false)
          .getSharedPreferences(context)
          .then((value) {
        if (!value) {
          debugPrint('go LoginPage');
          Navigator.pushNamedAndRemoveUntil(
              context, '/LoginPage', (route) => false);
        } else {
          debugPrint('go MainPage');
          Navigator.pushNamedAndRemoveUntil(
              context, '/MainPage', (route) => false);
        }
      });
    }
  }
}
