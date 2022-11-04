import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/navigation_provider/navigation_provider.dart';
import 'package:quel_prof/view/calendar_page.dart';
import 'package:quel_prof/view/chat_page.dart';
import 'package:quel_prof/view/courses_page.dart';
import 'package:quel_prof/view/error_page.dart';
import 'package:quel_prof/view/home_page.dart';
import 'package:quel_prof/widgets/AppBars/calendar_appbar.dart';
import 'package:quel_prof/widgets/AppBars/home_appbar.dart';
import 'package:quel_prof/widgets/AppBars/my_appbar.dart';
import 'package:quel_prof/widgets/other/myDrawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => setSystemUIOverlayStyle());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: _onAppBarChanged(
          Provider.of<ProviderNavigation>(context).currentPage),
      drawer: const MyDrawer(),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor:
            Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.indicator,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        padding: const EdgeInsets.all(12),
        snakeViewColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        selectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor:
            Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: Provider.of<ProviderNavigation>(context).currentPage,
        onTap: (index) => setState(() =>
            Provider.of<ProviderNavigation>(context, listen: false)
                .currentPage = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'calendar'),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_outlined), label: 'myCourses'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'account')
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
      body: WillPopScope(
        onWillPop: () async => Provider.of<ProviderNavigation>(context, listen: false).goBack(),
        child: IndexedStack(
          index: Provider.of<ProviderNavigation>(context).currentPage,
          children: const [
            HomePage(),
            CalendarPage(),
            CoursesPage(),
            ChatPage(),
            // SizedBox(),
            ErrorPage(),
            ErrorPage()
          ],
        ),
      ),
    );
  }

  Widget _onPageChanged(int page) {
    switch (page) {
      case 0:
        return const HomePage();

      case 1:
        return const CalendarPage();

      case 2:
        return const SizedBox();

      case 3:
        return const SizedBox();

      case 4:
        return const SizedBox();

      default:
        return const SizedBox();
    }
  }

  AppBar _onAppBarChanged(int page) {
    switch (page) {
      case 0:
        return HomeAppBar(
          primaryColor: Theme.of(context).primaryColor,
          context: context,
        );

      case 1:
        return CalendarAppBar(
          primaryColor: Theme.of(context).primaryColor,
          context: context,
        );

      case 2:
        return MyAppBar(
          primaryColor: Theme.of(context).primaryColor,
          context: context,
        );

      case 3:
        return MyAppBar(
          primaryColor: Theme.of(context).primaryColor,
          context: context,
        );

      case 4:
        return MyAppBar(
          primaryColor: Theme.of(context).primaryColor,
          context: context,
        );

      default:
        return MyAppBar(
          primaryColor: Theme.of(context).primaryColor,
          context: context,
        );
    }
  }

  void setSystemUIOverlayStyle() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).backgroundColor,
    ));
  }
}
