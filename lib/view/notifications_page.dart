import 'package:flutter/material.dart';
import 'package:quel_prof/widgets/notifications_page/notifications_item.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/widgets/other/MyCustomScrollBehavior.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => _goBack(),
      child: ScrollConfiguration(
        behavior: MyCustomScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          controller: ScrollController(),
          child: Column(
            children: [
              const SizedBox(height: 10),
              NotificationsItem(
                  title: 'Lorem Ipsum',
                  text:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore…'),
              NotificationsItem(
                  title: 'Lorem Ipsum',
                  text:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore…'),
              NotificationsItem(
                  title: 'Lorem Ipsum',
                  text:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore…'),
              NotificationsItem(
                  title: 'Lorem Ipsum',
                  text:
                      'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore…'),
            ],
          ),
        ),
      ),
    );
  }

  _goBack() {
    Navigator.of(context).pop();
  }
}
