import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'Coming Soon',
      style: TextStyle(
          fontSize: 42.0,
          fontWeight: FontWeight.w200,
          color: Theme.of(context).primaryColor),
    ));
  }
}
