import 'package:flutter/material.dart';

class HolidayItem extends StatelessWidget {
  String holidayName;
  DateTime date;

  HolidayItem({
    Key? key,
    required this.holidayName,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        debugPrint(holidayName);
      },
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 68),
        child: Container(
          // height: 63,
          width: 320,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 15,
          ),
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Column(
            children: [
              SizedBox(
                width: 320,
                child: Text(
                  holidayName,
                  style: TextStyle(
                    fontSize: 15,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
