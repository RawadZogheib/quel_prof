import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/settings_provider/provider_language.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;
import 'package:quel_prof/widgets/home/adds_container.dart';
import 'package:quel_prof/widgets/home/fading_images_slider.dart';
import 'package:quel_prof/widgets/other/MyCustomScrollBehavior.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _k = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.12, //110,
          width: MediaQuery.of(context).size.width,
          // margin: const EdgeInsets.symmetric(horizontal: 6.0),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            boxShadow: const [
              // BoxShadow(
              //   color: Colors.grey,
              //   offset: Offset(0.0, 1.0), //(x,y)
              //   blurRadius: 6.0,
              // ),
            ],
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(22.0),
              bottomRight: Radius.circular(22.0),
            ),
          ),
          child: Row(
            children: [
              const SizedBox(width: 30),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Consumer<ProviderLanguage>(
                        builder: (context, providerLanguage, _) {
                      return Center(
                        child: Text(
                          DateFormat('EEEE, dd MMMM, yyyy',
                                  providerLanguage.currentLanguage.languageCode)
                              .format(DateTime.now())
                              .toString(),
                          // 'Monday, 22 June, 2022',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: my_colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }),
                    const SizedBox(height: 40)
                  ],
                ),
              ),
              const SizedBox(width: 30),
            ],
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: MyCustomScrollBehavior().copyWith(scrollbars: false),
            child: SingleChildScrollView(
              controller: ScrollController(),
              child: Container(
                key: ValueKey(_k++),
                height: MediaQuery.of(context).size.height * 0.48,
                margin: const EdgeInsets.only(top: 16),
                child: FadingImagesSlider(
                  activeIconColor:
                      Provider.of<ProviderTheme>(context).themeMode == 'dark'
                          ? my_colors.activeIconColorDark
                          : my_colors.activeIconColorLight,
                  passiveIconColor:
                      Provider.of<ProviderTheme>(context).themeMode == 'dark'
                          ? my_colors.passiveIconColorDark
                          : my_colors.passiveIconColorColorLight,
                  // animationDuration: const Duration(seconds: 3),
                  autoFade: false,
                  images: [
                    AddsContainer(
                      key: const ValueKey(0),
                      title: 'Heyy',
                      text:
                          '''Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren''',
                    ),
                    AddsContainer(
                      key: const ValueKey(1),
                      text: 'Empty',
                    ),
                    AddsContainer(
                      key: const ValueKey(2),
                      text: '',
                    ),
                  ],
                  iconSize: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
