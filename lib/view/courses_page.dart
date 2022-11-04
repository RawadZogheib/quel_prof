import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/courses/provider_courses.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: Provider.of<ProviderCourses>(context, listen: false).courses,
      ),
    );
  }
}
