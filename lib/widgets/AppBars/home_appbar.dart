import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quel_prof/controller/other/is_rtl.dart';
import 'package:quel_prof/data/my_colors.dart' as my_colors;

class HomeAppBar extends AppBar {
  Color primaryColor;
  BuildContext context;

  HomeAppBar({
    required this.primaryColor,
    required this.context,
  }) : super(
          backgroundColor: primaryColor,
          //primaryColor,
          elevation: 0.0,
          leading: Builder(
            builder: (context) => Row(
              children: [
                const SizedBox(width: 30.0),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    onTap: () => Scaffold.of(context).openDrawer(),
                    child: Transform(
                      alignment: Alignment.center,
                      transform:
                          Matrix4.rotationY(isRTL(context) ? math.pi : 0),
                      child: SvgPicture.asset(
                        'Assets/Icons/Group 8.svg',
                        color: my_colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          leadingWidth: 65,
          actions: [
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () => debugPrint('NotificationsPage'),
              child: SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  'Assets/Icons/notification.svg',
                  color: my_colors.white,
                ),
              ),
            ),
            const SizedBox(width: 16.0),
            InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: () => debugPrint('SettingsPage'),
              child: SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  'Assets/Icons/setting-2.svg',
                  color: my_colors.white,
                ),
              ),
            ),
            const SizedBox(width: 30.0),
          ],
        );
}
