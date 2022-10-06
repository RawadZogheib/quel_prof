import 'package:flutter/material.dart';
import 'package:quel_prof/data/data.dart' as data;
import 'package:quel_prof/data/my_colors.dart' as my_colors;

class btn extends StatelessWidget {
  var btnText;
  var onTap;

  btn({required this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 100,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9.0),
          color: my_colors.primaryDark.withOpacity(0.6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(btnText,style: TextStyle(color: my_colors.primaryLight),),
        ));
  }
}
