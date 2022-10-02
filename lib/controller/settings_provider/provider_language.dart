import 'package:flutter/material.dart';
import 'package:quel_prof/api/my_session.dart';

class ProviderLanguage extends ChangeNotifier {
  Locale _currentLanguage = const Locale.fromSubtags(languageCode: 'en');

  Locale get currentLanguage => _currentLanguage;


  // Future<void> setLanguage() async {
  //   if (_currentLanguage.languageCode != 'en') {
  //     _currentLanguage = const Locale.fromSubtags(languageCode: 'en');
  //     await SessionManager().set('language', 'en');
  //     notifyListeners();
  //     return;
  //   }
  //   if (_currentLanguage.languageCode != 'ar') {
  //     _currentLanguage = const Locale.fromSubtags(languageCode: 'ar');
  //     await SessionManager().set('language', 'ar');
  //     notifyListeners();
  //     return;
  //   }
  // }

  Future<void> setLanguageEn() async {
    if (_currentLanguage.languageCode != 'en') {
      _currentLanguage = const Locale.fromSubtags(languageCode: 'en');
      await SessionManager().set('language', 'en');
      notifyListeners();
    }
  }

  Future<void> setLanguageAr() async {
    if (_currentLanguage.languageCode != 'ar') {
      _currentLanguage = const Locale.fromSubtags(languageCode: 'ar');
      await SessionManager().set('language', 'ar');
      notifyListeners();
    }
  }

  Future<void> setInitLanguage() async {
    try {
      if (await SessionManager().get('language') == 'en') {
        _currentLanguage = const Locale.fromSubtags(languageCode: 'en');
        notifyListeners();
      }

      if (await SessionManager().get('language') == 'ar') {
        _currentLanguage = const Locale.fromSubtags(languageCode: 'ar');
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  FontWeight? setFontWeight(String itemLangCode) {
    return _currentLanguage.languageCode == itemLangCode ? FontWeight.bold : null;
  }

  double setFontSize(String itemLangCode) {
    return _currentLanguage.languageCode == itemLangCode ? 17.0 : 14.0;
  }
}
