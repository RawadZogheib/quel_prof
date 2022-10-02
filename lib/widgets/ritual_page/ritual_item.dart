import 'package:flutter/material.dart';

class RitualItem extends StatelessWidget {
  String title;
  String text;

  RitualItem({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20.0),
      decoration: BoxDecoration(
        color: Theme.of(context).textTheme.headline3?.color,
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Theme.of(context).textTheme.headline1?.color,
                fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            text,
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.color
                    ?.withOpacity(0.4),
                fontSize: 17),
          )
        ],
      ),
    );
  }
}
