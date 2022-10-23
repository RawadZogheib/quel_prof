import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/login/provider_login.dart';
import 'package:quel_prof/controller/navigation_provider/navigation_provider.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:quel_prof/firebase_options.dart';
import 'package:quel_prof/l10n/l10n.dart';
import 'package:quel_prof/view/fist_page.dart';
import 'package:quel_prof/view/login_page.dart';
import 'package:quel_prof/view/main_page.dart';

// String? arg; //initial value

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // debugPaintSizeEnabled=true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProviderTheme()),
        ChangeNotifierProvider(create: (context) => ProviderLanguage()),
        ChangeNotifierProvider(create: (context) => ProviderNavigation()),
        ChangeNotifierProvider(create: (context) => ProviderLogin()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'Quel Prof',
          debugShowCheckedModeBanner: false,
          theme: Provider.of<ProviderTheme>(context).getThemeMode(),
          initialRoute: '/FirstPage',
          routes: {
            '/FirstPage': (context) => const FirstPage(),
            '/LoginPage': (context) => const LoginPage(),
            '/MainPage': (context) => const MainPage(),
          },
          locale: Provider.of<ProviderLanguage>(context).currentLanguage,
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
        );
      },
    );
  }
}
//Session:
//email
//password
//themeMode => light/dark
//language => en/ar
