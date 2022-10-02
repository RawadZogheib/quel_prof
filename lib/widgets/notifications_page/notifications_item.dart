import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsItem extends StatelessWidget {
  String title;
  String text;

  NotificationsItem({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      width: MediaQuery
          .of(context)
          .size
          .width,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .headline6
                              ?.color,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      text,
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .headline6
                              ?.color
                              ?.withOpacity(0.4),
                          fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              // SizedBox(
              //   width: 30,
              //   child: InkWell(
              //     highlightColor: Colors.transparent,
              //     splashColor: Colors.transparent,
              //     hoverColor: Colors.transparent,
              //     onTap: () => _onUnDelete(),
              //     child: SizedBox(
              //       height: 22,
              //       width: 22,
              //       child: SvgPicture.asset(
              //         'Assets/Icons/trash.svg',
              //         color: Theme
              //             .of(context)
              //             .textTheme
              //             .headline6
              //             ?.color,
              //       ),
              //     ),
              //   ),
              // )
            ],
          ),
          Divider(
            thickness: 1.0,
            color: Theme
                .of(context)
                .textTheme
                .headline6
                ?.color,
          )
        ],
      ),
    );
  }

  // _onUnDelete() {
  //   debugPrint('onUnSave');
  // }

}