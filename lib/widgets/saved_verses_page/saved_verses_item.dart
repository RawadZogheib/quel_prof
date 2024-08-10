import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';

class SavedVersesItem extends StatelessWidget {
  String title;
  String text;

  SavedVersesItem({
    Key? key,
    required this.title,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 110,
      width: MediaQuery.of(context).size.width,
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
                          color: Theme.of(context).textTheme.titleLarge?.color,
                          fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      text,
                      style: TextStyle(
                          color: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.color
                              ?.withOpacity(0.4),
                          fontSize: 17),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              SizedBox(
                width: 30,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () => _onUnSave(),
                      child: SizedBox(
                        height: 22,
                        width: 22,
                        child: SvgPicture.asset(
                          'Assets/Icons/heart(1).svg',
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: () async => await _onShare(),
                      child: SizedBox(
                        height: 22,
                        width: 22,
                        child: SvgPicture.asset(
                          'Assets/Icons/vuesax-linear-export.svg',
                          color: Theme.of(context).textTheme.titleLarge?.color,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Divider(
            thickness: 1.0,
            color: Theme.of(context).textTheme.titleLarge?.color,
          )
        ],
      ),
    );
  }

  _onUnSave() {
    debugPrint('onUnSave');
  }

  Future<void> _onShare() async {
    debugPrint('share_outlined');
    debugPrint(text);
    await Share.share(text.isEmpty ? 'Error!!' : text,
        subject: text.isEmpty ? 'Error!!' : text);
  }

}
