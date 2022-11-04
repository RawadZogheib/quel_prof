import 'dart:math' as math; // import this

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:paged_vertical_calendar/utils/date_utils.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/courses/provider_courses.dart';
import 'package:quel_prof/controller/other/is_rtl.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;
import 'package:quel_prof/widgets/Other/MyCustomScrollBehavior.dart';
import 'package:quel_prof/widgets/calendar_page/course_item.dart';

class MyCustomCalender extends StatefulWidget {
  Function(DateTime, List<CourseItem>) onDayPressed;

  MyCustomCalender({
    Key? key,
    required this.onDayPressed,
  }) : super(key: key);

  @override
  State<MyCustomCalender> createState() => _MyCustomCalenderState();
}

class _MyCustomCalenderState extends State<MyCustomCalender> {
  int _month = DateTime.now().month;
  int _year = DateTime.now().year;

  int _scapeDay = -999;
  bool _isLoading = true;

  final List<String> _dayName = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  DateTime _selectedDate =
      DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now().toLocal()));

  // List<CourseItem> _courses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () async {
      if(mounted) {
        await Provider.of<ProviderCourses>(context, listen: false).onInitState(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(35.0, 1.0, 35.0, 1.0),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .primaryColor, //Colors.white, //HexColor('#fafafa'),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        //border: Border.all(width: 1),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () => _goLeft(),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRTL(context) ? math.pi : 0),
                    child: SvgPicture.asset(
                      'Assets/Icons/arrow-circle-left.svg',
                      height: 26,
                      width: 26,
                      color: my_colors.backgroundLight,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  margin: const EdgeInsets.all(10),
                  child: Consumer<ProviderLanguage>(
                      builder: (context, providerLanguage, _) {
                    return Text(
                      DateFormat('MMMM yyyy',
                              providerLanguage.currentLanguage.languageCode)
                          .format(DateTime(_year, _month)),
                      style: Theme.of(context)
                          .textTheme
                          .headline6
                          ?.copyWith(color: my_colors.backgroundLight),
                    );
                  }),
                ),
                InkWell(
                  onTap: () => _goRight(),
                  child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(isRTL(context) ? math.pi : 0),
                    child: SvgPicture.asset(
                      'Assets/Icons/arrow-circle-right.svg',
                      height: 26,
                      width: 26,
                      color: my_colors.backgroundLight,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// add a row showing the weekdays
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                weekText(
                  AppLocalizations.of(context)!.monday,
                ),
                weekText(
                  AppLocalizations.of(context)!.tuesday,
                ),
                weekText(
                  AppLocalizations.of(context)!.wednesday,
                ),
                weekText(
                  AppLocalizations.of(context)!.thursday,
                ),
                weekText(
                  AppLocalizations.of(context)!.friday,
                ),
                weekText(
                  AppLocalizations.of(context)!.saturday,
                ),
                weekText(
                  AppLocalizations.of(context)!.sunday,
                ),
                // weekText('Mo'),
                // weekText('Tu'),
                // weekText('We'),
                // weekText('Th'),
                // weekText('Fr'),
                // weekText('Sa'),
                // weekText('Su'),
              ],
            ),
          ),
          Expanded(
            child: _isLoading
                ? ScrollConfiguration(
                    behavior:
                        MyCustomScrollBehavior().copyWith(overscroll: false),
                    child: GridView.builder(
                      padding: const EdgeInsets.only(top: 0),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        DateTime date = DateTime(_year, _month, index);
                        if (_scapeDay == -999) {
                          // print('=======================');
                          // _calculateHolidays(date);
                          _scapeDay =
                              _dayName.indexOf(DateFormat('E').format(date));
                        }
                        date = DateTime(_year, _month, index - _scapeDay);
                        if (index == 41) {
                          _scapeDay = -999;
                        }
                        // bool isHoliday = _checkIsHoliday(date);
                        return InkWell(
                          onTap: () => _selectDate(date),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 4.0,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: date.isAtSameMomentAs(DateTime.parse(
                                          DateFormat('yyyy-MM-dd').format(
                                              DateTime.now().toLocal())))
                                      ? Colors.transparent.withOpacity(0.3)
                                      : null, //HexColor('#dfe2e6'),
                                  // borderRadius: const BorderRadius.all(
                                  //   Radius.circular(300.0),
                                  // ),
                                  border: date.isAtSameMomentAs(_selectedDate)
                                      ? Border.all(
                                          width: 2,
                                          color: my_colors.backgroundDark,
                                        )
                                      : null,
                                ),
                                child: Consumer<ProviderLanguage>(
                                    builder: (context, providerLanguage, _) {
                                  return Text(
                                    DateFormat(
                                            'd',
                                            providerLanguage
                                                .currentLanguage.languageCode)
                                        .format(date),
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: date.isAtSameMomentAs(
                                                DateTime.parse(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.now()
                                                            .toLocal())))
                                            ? null
                                            : my_colors.backgroundDark
                                                .withOpacity(
                                                    date.month.toInt() != _month
                                                        ? 0.4
                                                        : 1)),
                                  );
                                }),
                              ),
                              _checkIsCourse(date)
                                  ? Positioned(
                                      bottom: 6.5,
                                      child: Icon(
                                        Icons.circle,
                                        color: date.isAtSameMomentAs(
                                                DateTime.parse(
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(DateTime.now()
                                                            .toLocal())))
                                            ? my_colors.primaryLight
                                            : my_colors.backgroundDark,
                                        size: 5,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ],
                          ),
                        );
                      },
                      itemCount: 42,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 42,
                        crossAxisCount: 7,
                      ),
                    ),
                  )
                : const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }

  Widget weekText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  _selectDate(DateTime date) {
    _selectedDate = date;
    List<CourseItem> holidaysTMP = [];
    // if (_courses.containsKey(date.year)) {
    holidaysTMP.addAll(Provider.of<ProviderCourses>(context, listen: false)
        .courses
        .where((element) => element.date.isSameDay(date)));
    // }
    widget.onDayPressed(date, holidaysTMP);
  }

  bool _checkIsCourse(DateTime date) {
    // if (_courses.containsKey(date.year)) {
    if (Provider.of<ProviderCourses>(context)
        .courses
        .where((element) => element.date.isSameDay(date))
        .isNotEmpty) {
      return true;
    }
    // }
    return false;
  }

  _goLeft() {
    setState(() {
      _month--;
      if (_month == 0) {
        _month = 12;
        _year--;
      }
    });
  }

  _goRight() {
    setState(() {
      _month++;
      if (_month == 13) {
        _month = 1;
        _year++;
      }
    });
  }
}
