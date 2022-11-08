import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/courses/provider_courses.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({Key? key}) : super(key: key);

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero, () async {
      if(mounted) {
        await Provider.of<ProviderCourses>(context, listen: false).onInitState(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 8.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        children: Provider.of<ProviderCourses>(context).courses,
      ),
    );
  }
}
