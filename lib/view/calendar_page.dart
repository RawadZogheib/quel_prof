import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;
import 'package:quel_prof/widgets/Other/MyCustomScrollBehavior.dart';
import 'package:quel_prof/widgets/calendar_page/holiday_item.dart';
import 'package:quel_prof/widgets/calendar_page/my_custom_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _date = DateTime.now();
  final List<HolidayItem> _holidayItems = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          // color: globals.brown2,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              // tileMode: TileMode.decal,
              colors: [
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
                Theme.of(context).backgroundColor,
              ],
            ),
          ),
        ),
        ScrollConfiguration(
          behavior: MyCustomScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: [
                SizedBox(
                  height: 355,
                  child: MyCustomCalender(
                    onDayPressed: (date, holidayItem) =>
                        _onDayPressed(date, holidayItem),
                  ),
                ),
                Container(
                  height: 20.0,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: Center(
                            child: Container(
                              height: 8,
                              width: 170,
                              decoration: BoxDecoration(
                                color: Provider.of<ProviderTheme>(context)
                                            .themeMode ==
                                        'dark'
                                    ? my_colors.darkBlue2
                                    : my_colors.white,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(300.0)),
                              ),
                            ),
                          ),
                          // title: Icon(
                          //   Icons.keyboard_arrow_down,
                          //   size: 36,
                          // ),
                        ),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 40.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Consumer<ProviderLanguage>(
                                    builder: (context, providerLanguage, _) {
                                  return Text(
                                    DateFormat(
                                            'EEEE, d MMM',
                                            providerLanguage
                                                .currentLanguage.languageCode)
                                        .format(_date),
                                    style: TextStyle(
                                      color: my_colors.primaryLight
                                          .withOpacity(0.8),
                                      fontSize: 27.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  );
                                }),
                                const SizedBox(height: 8.0),
                                _holidayItems.isEmpty
                                    ? Text(
                                        // AppLocalizations.of(context)!.noHoliday,
                                        'No course available',
                                        style: TextStyle(
                                          color: my_colors.primaryLight
                                              .withOpacity(0.5),
                                          fontSize: 20.0,
                                        ),
                                      )
                                    : Text(
                                        'Courses available',
                                        style: TextStyle(
                                          color: my_colors.primaryLight
                                              .withOpacity(0.5),
                                          fontSize: 20.0,
                                        ),
                                      ),
                                const SizedBox(height: 20),
                                _holidayItems.isNotEmpty
                                    ? Expanded(
                                        child: Column(
                                          children: _holidayItems,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(height: 2.0)
                              ],
                            ),
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _onDayPressed(DateTime date, List<HolidayItem> holidayItem) {
    debugPrint(DateFormat('yyyy-MM-dd').format(date));
    setState(() {
      _date = date;
    });
    _holidayItems.clear();
    _holidayItems.addAll(holidayItem);
    // _open(date);
    // _checkIfIsLoggedIn(date);
  }
}

// _open(DateTime date) {
//   showModalBottomSheet<void>(
//     isScrollControlled: true,
//     backgroundColor: Colors.transparent,
//     context: context,
//     builder: (BuildContext context) {
//       return Container(
//           height: MediaQuery.of(context).size.height * 0.45,
//           padding: EdgeInsets.only(
//               bottom: MediaQuery.of(context).viewInsets.bottom),
//           decoration: BoxDecoration(
//             color: Theme.of(context).primaryColor,
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(30),
//               topRight: Radius.circular(30),
//             ),
//           ),
//           child: Column(
//             children: [
//               ListTile(
//                 title: Center(
//                   child: Container(
//                     height: 8,
//                     width: 170,
//                     decoration: BoxDecoration(
//                       color: globals.brown1,
//                       borderRadius:
//                       const BorderRadius.all(Radius.circular(300.0)),
//                     ),
//                   ),
//                 ),
//                 // title: Icon(
//                 //   Icons.keyboard_arrow_down,
//                 //   size: 36,
//                 // ),
//               ),
//               Expanded(
//                 child: Container(
//                   width: 10000,
//                   padding: const EdgeInsets.symmetric(horizontal: 40.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         DateFormat('EEEE, MMM d').format(date),
//                         style: TextStyle(
//                           color: Theme.of(context)
//                               .textTheme
//                               .bodyText1
//                               ?.color
//                               ?.withOpacity(0.8),
//                           fontSize: 27.0,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       const SizedBox(height: 8.0),
//                       Text(
//                         'No holiday',
//                         style: TextStyle(
//                           color: Theme.of(context)
//                               .textTheme
//                               .bodyText1
//                               ?.color
//                               ?.withOpacity(0.3),
//                           fontSize: 20.0,
//                         ),
//                       ),
//                       const SizedBox(height: 30)
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ));
//     },
//   ).then((exit) {});
// }
