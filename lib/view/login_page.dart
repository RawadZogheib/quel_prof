import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/login/provider_login.dart';
import 'package:quel_prof/controller/navigation_provider/navigation_provider.dart';
import 'package:quel_prof/data/data.dart' as data;
import 'package:quel_prof/data/my_colors.dart' as my_colors;
import 'package:quel_prof/widgets/PopUp/errorWarningPopup.dart';
import 'package:quel_prof/widgets/button/myButton.dart';
import 'package:quel_prof/widgets/textInput/myTextInput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController textEditingControllerEmail = TextEditingController();
  TextEditingController textEditingControllerPassword = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<ProviderLogin>(context, listen: false)
        .getSharedPreferences(context)
        .then((value) {
      textEditingControllerEmail.text =
          Provider.of<ProviderLogin>(context, listen: false).email;
      textEditingControllerPassword.text =
          Provider.of<ProviderLogin>(context, listen: false).password;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          Provider.of<ProviderNavigation>(context, listen: false).goBack(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 35.0, left: 8.0, right: 8.0, bottom: 22.0),
                      child: Container(
                        width: 300,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                          'Assets/launch_icon/167d298c-cef9-4317-b600-d8da249d4d2b.png',
                          height: 150,
                          width: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 40.0, color: my_colors.primaryLight),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width * 0.05,
                            top: 18.0,
                            right: MediaQuery.of(context).size.width * 0.05,
                            bottom: 8.0),
                        child: SizedBox(
                          width: 400,
                          height: 65,
                          child: myTextInput(
                            textEditingController: textEditingControllerEmail,
                            textString: "Enter Your Email Address",
                            labelText: 'Enter Your Email Address',
                            colBlue:
                                Provider.of<ProviderLogin>(context).colorEmail,
                            colBlue_1:
                                Provider.of<ProviderLogin>(context).colorEmail1,
                            colBlue_2:
                                Provider.of<ProviderLogin>(context).colorEmail2,
                            textInputAction: TextInputAction.next,
                            spaceAllowed: false,
                            obscure: false,
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.05,
                          top: 8.0,
                          right: MediaQuery.of(context).size.width * 0.05,
                          bottom: 8.0),
                      child: SizedBox(
                        width: 500,
                        height: 65,
                        child: myTextInput(
                          textEditingController: textEditingControllerPassword,
                          textString: "Enter Your Password",
                          labelText: 'Enter Your Password',
                          colBlue:
                              Provider.of<ProviderLogin>(context).colorPassword,
                          colBlue_1: Provider.of<ProviderLogin>(context)
                              .colorPassword1,
                          colBlue_2: Provider.of<ProviderLogin>(context)
                              .colorPassword2,
                          maxLines: 1,
                          textInputAction: TextInputAction.none,
                          spaceAllowed: false,
                          obscure: true,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(28.0),
                      child: InkWell(
                        child: btn(btnText: "Submit"),
                        onTap: () {
                          try {
                            Provider.of<ProviderLogin>(context, listen: false)
                                .login(
                                    context,
                                    textEditingControllerEmail.value.text,
                                    textEditingControllerPassword.value.text);
                          } catch (e) {
                            errorPopup(context, data.errorException);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
