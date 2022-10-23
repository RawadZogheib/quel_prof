import 'package:flutter/material.dart';

class CourseItem extends StatelessWidget {
  String courseId;
  String courseName;
  DateTime date;

  CourseItem({
    Key? key,
    required this.courseId,
    required this.courseName,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onTap: () {
        debugPrint(courseName);
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
                  courseName,
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
