import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/login/provider_login.dart';
import 'package:quel_prof/controller/navigation_provider/navigation_provider.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;
import 'package:quel_prof/widgets/other/MyCustomScrollBehavior.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Theme.of(context).backgroundColor, //globals.blue1,
        child: ScrollConfiguration(
          behavior: MyCustomScrollBehavior(),
          child: ListView(
            controller: ScrollController(),
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(height: 10.0),
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    child: Image.asset(
                      'Assets/launch_icon/167d298c-cef9-4317-b600-d8da249d4d2b.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Divider(
                    thickness: 1.0,
                    color:
                        Provider.of<ProviderTheme>(context).themeMode == 'light'
                            ? Colors.black87
                            : Colors.white70,
                    indent: 12.0,
                    endIndent: 12.0,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        MenuItem(
                          text: 'Home',
                          //'Daily Verses',
                          imageString: Icons.home,
                          color: Theme.of(context).primaryColor,
                          onClicked: () => selectedItem(context, 0),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'Calendar',
                          //'Full Calendar',
                          imageString: Icons.calendar_month,
                          color: Theme.of(context).primaryColor,
                          onClicked: () => selectedItem(context, 1),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'My Courses',
                          //'Bible',
                          imageString: Icons.book_outlined,
                          color: Theme.of(context).primaryColor,
                          onClicked: () => selectedItem(context, 2),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: 'Chat',
                          //'Saved Verses',
                          imageString: Icons.chat,
                          color: Theme.of(context).primaryColor,
                          onClicked: () => selectedItem(context, 3),
                        ),
                        const SizedBox(height: 5),
                        MenuItem(
                          text: AppLocalizations.of(context)!.darkMode,
                          //'Dark Mode',
                          widget: GFToggle(
                            // key: const ValueKey(0),
                            value:
                                Provider.of<ProviderTheme>(context).themeMode ==
                                    'dark',
                            type: GFToggleType.ios,
                            enabledThumbColor: my_colors.backgroundDark,
                            enabledTrackColor: Theme.of(context).primaryColor,
                            onChanged: (bool? value) async {
                              // _isDark = value!;
                              await selectedItem(context, 4);
                            },
                          ),
                          imageString: Icons.dark_mode_outlined,
                          color: Theme.of(context).primaryColor,
                          // onClicked: () => ,
                        ),
                        const SizedBox(height: 5),
                        // Container(
                        //   height: 50,
                        //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       SizedBox(
                        //         height: 22,
                        //         width: 22,
                        //         child: SvgPicture.asset(
                        //           'Assets/Icons/global.svg',
                        //           color: Theme.of(context).primaryColor,
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         width: 185,
                        //         child: Row(
                        //           children: [
                        //             InkWell(
                        //               highlightColor: Colors.transparent,
                        //               splashColor: Colors.transparent,
                        //               hoverColor: Colors.transparent,
                        //               onTap: () => selectedItem(context, 5),
                        //               child: Text(
                        //                 'EN',
                        //                 style: TextStyle(
                        //                   color: Theme.of(context).primaryColor,
                        //                   fontWeight:
                        //                       Provider.of<ProviderLanguage>(
                        //                               context)
                        //                           .setFontWeight('en'),
                        //                   fontSize:
                        //                       Provider.of<ProviderLanguage>(
                        //                               context)
                        //                           .setFontSize('en'),
                        //                 ),
                        //               ),
                        //             ),
                        //             Text(
                        //               ' | ',
                        //               style: TextStyle(
                        //                   color: Theme.of(context).primaryColor,
                        //                   fontSize: 17),
                        //             ),
                        //             InkWell(
                        //               highlightColor: Colors.transparent,
                        //               splashColor: Colors.transparent,
                        //               hoverColor: Colors.transparent,
                        //               onTap: () => selectedItem(context, 6),
                        //               child: Text(
                        //                 'AR',
                        //                 style: TextStyle(
                        //                   color: Theme.of(context).primaryColor,
                        //                   fontWeight:
                        //                       Provider.of<ProviderLanguage>(
                        //                               context)
                        //                           .setFontWeight('ar'),
                        //                   fontSize:
                        //                       Provider.of<ProviderLanguage>(
                        //                               context)
                        //                           .setFontSize('ar'),
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       )
                        //     ],
                        //   ),
                        // ),
                        MenuItem(
                          text: 'Logout',
                          //'Logout',
                          imageString: Icons.logout,
                          color: Theme.of(context).primaryColor,
                          onClicked: () => selectedItem(context, 5),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectedItem(BuildContext context, int index) async {
    switch (index) {
      case 0: // My DailyPage
        // if (Provider.of<ProviderGlobal>(context, listen: false).currentPage !=
        //     'DailyPage') {
        //   Provider.of<ProviderGlobal>(context, listen: false).goTo('DailyPage');
        // }
        Provider.of<ProviderNavigation>(context, listen: false)
            .currentPage = index;
        Navigator.of(context).pop();
        break;
      case 1: // CalendarPage
        Provider.of<ProviderNavigation>(context, listen: false)
            .currentPage = index;
        Navigator.of(context).pop();
        // widget.setState();
        break;
      case 2: // BiblePage
        Provider.of<ProviderNavigation>(context, listen: false)
            .currentPage = index;
        Navigator.of(context).pop();
        // widget.setState();
        break;
      case 3: // SavedVerses
        Provider.of<ProviderNavigation>(context, listen: false)
            .currentPage = index;
        Navigator.of(context).pop();
        break;
      case 4: // Change Theme
        Provider.of<ProviderTheme>(context, listen: false).setThemeMode();
        break;

      case 5: // Logout
        Provider.of<ProviderLogin>(context, listen: false).logout(context);
        break;
    }
  }
}

class MenuItem extends StatelessWidget {
  String text;
  Widget? widget;
  IconData imageString;
  Color? color;
  VoidCallback? onClicked;

  MenuItem({
    required this.text,
    this.widget = const SizedBox.shrink(),
    required this.imageString,
    required this.color,
    this.onClicked,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Color color = globals.whiteBlue;//Colors.white;
    Color hoverColor = Colors.transparent.withOpacity(1); //Colors.white70;

    return ListTile(
      leading: SizedBox(
          height: 22,
          width: 22,
          child: Icon(imageString, color: color)),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: TextStyle(color: color, fontSize: 14)),
          widget!
        ],
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}

class SearchFieldDrawer extends StatelessWidget {
  const SearchFieldDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;

    return TextField(
      style: const TextStyle(color: color, fontSize: 14),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        hintText: 'Search',
        hintStyle: const TextStyle(color: color),
        prefixIcon: const Icon(
          Icons.search,
          color: color,
          size: 20,
        ),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }
}
