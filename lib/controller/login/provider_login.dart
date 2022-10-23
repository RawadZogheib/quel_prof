import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quel_prof/api/my_session.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;
import 'package:quel_prof/firebase_options.dart';
import 'package:quel_prof/widgets/PopUp/errorWarningPopup.dart';

class ProviderLogin extends ChangeNotifier {
  String? _email;
  String? _password;
  Color colorEmail = my_colors.primaryDark.withOpacity(0.3);
  Color colorEmail1 = my_colors.primaryLight;
  Color colorEmail2 = my_colors.primaryLight;
  Color colorPassword = my_colors.primaryDark.withOpacity(0.3);
  Color colorPassword1 = my_colors.primaryLight;
  Color colorPassword2 = my_colors.primaryLight;

  bool _isLoading = false;

  String get email {
    if (_email != null) {
      return _email!;
    }
    return '';
  }

  String get password {
    if (_password != null) {
      return _password!;
    }
    return '';
  }

  Future<void> login(
      BuildContext context, String valueEmail, String valuePassword) async {
    if (!_isLoading) {
      _isLoading = true;
      _email = valueEmail;
      _password = valuePassword;
      debugPrint('$_email + $_password');
      if (_email == null || _password == null) {
        debugPrint('Email or Password is empty');
        return;
      }
      try {
        // await Firebase.initializeApp(
        //   options: DefaultFirebaseOptions.currentPlatform,
        // );
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email!, password: _password!);

        /// On Success
        await SessionManager().set('email', _email.toString());
        await SessionManager().set('password', _password.toString());
        Navigator.pushNamedAndRemoveUntil(
            context, '/MainPage', (route) => false);
      } on FirebaseAuthException catch (e) {
        errorPopup(context, 'Failed with error code: ${e.code}');
        debugPrint('Failed with error code: ${e.code}');
        debugPrint(e.message);
      }
      _isLoading = true;
    }
  }

  Future<bool> getSharedPreferences(BuildContext context) async {
    // await SessionManager().destroy();
    if (await SessionManager().containsKey('email') &&
        await SessionManager().containsKey('password')) {
      _email = (await SessionManager().get('email')).toString();
      _password = (await SessionManager().get('password')).toString();
      // debugPrint('${_email!} + ${_password!}');
      if (_email != null && _password != null) {
        await login(context, _email!, _password!);
        return true;
      }
      notifyListeners();
    }
    return false;
  }

  Future<void> _getUserInfo() async {
    // //sessionManager.remove("arg");
    // print("CHATTTfffffffffffffff: ${body[6]}");
    // await SessionManager().set('token', body[1]);
    // await SessionManager().set('account_Id', body[2]);
    // await SessionManager().set('email', _email);
    // await SessionManager().set('username', body[3]);
    // await SessionManager().set('user_uni', body[4]);
    // await SessionManager().set('photo', body[5]);
    // await SessionManager().set('userTokenChat', body[6]);
    // await SessionManager().set('bio', body[8].toString());
  }

  Future<void> logout(BuildContext context) async {
    debugPrint('go LoginPage');
    await SessionManager().destroy();
    _isLoading = false;
    Navigator.pushNamedAndRemoveUntil(context, '/LoginPage', (route) => false);
  }
}
