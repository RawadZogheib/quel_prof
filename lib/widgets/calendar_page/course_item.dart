import 'package:flutter/material.dart';
import 'package:quel_prof/controller/other/capitaize.dart';

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
        constraints: const BoxConstraints(minHeight: 80),
        child: Container(
          // height: 63,
          width: 320,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(color: Theme.of(context).primaryColor)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 320,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        courseName.capitalize(),
                        style: TextStyle(
                            fontSize: 17,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // const Expanded(child: SizedBox.shrink()),
                    const SizedBox(width: 6),
                    Column(
                      children: [
                        Container(
                          height: 33,
                          width: 77,
                          decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(12.0))),
                          alignment: Alignment.center,
                          child: Text(
                            "Join",
                            style: TextStyle(
                              fontSize: 15,
                              color: Theme.of(context).backgroundColor,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${date.hour}:${date.minute}",
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 0),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
