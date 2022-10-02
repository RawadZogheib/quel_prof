import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quel_prof/controller/settings_provider/provider_theme.dart';
import 'package:quel_prof/widgets/other/MyCustomScrollBehavior.dart';
import 'package:share_plus/share_plus.dart';

class AddsContainer extends StatefulWidget {
  String title;
  String text;
  String imageURL;

  AddsContainer({
    Key? key,
    this.title = '',
    this.text = '',
    this.imageURL = '',
  }) : super(key: key);

  @override
  State<AddsContainer> createState() => _AddsContainerState();
}

class _AddsContainerState extends State<AddsContainer> {
  bool _visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 350), () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.43,
      width: MediaQuery.of(context).size.width * 0.92,
      decoration: BoxDecoration(
        color: widget.imageURL == '' ? Theme.of(context).primaryColor : null,
        image: widget.imageURL != ''
            ? DecorationImage(
                image: NetworkImage(widget.imageURL),
                fit: BoxFit.fill,
                colorFilter: ColorFilter.mode(
                    Provider.of<ProviderTheme>(context).themeMode == 'dark'
                        ? Colors.white.withOpacity(0.65)
                        : Colors.black.withOpacity(0.55),
                    Provider.of<ProviderTheme>(context).themeMode == 'dark'
                        ? BlendMode.lighten
                        : BlendMode.darken),
              )
            : null,
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.bottomLeft,
        //   colors: [
        //     HexColor('#b3c2c4'),
        //     HexColor('#b3c2c4'),
        //     HexColor('#b3c2c4'),
        //     HexColor('#dad7d6'),
        //     HexColor('#dad7d6'),
        //   ],
        // ),
        borderRadius: const BorderRadius.all(Radius.circular(22.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 30,
          right: 40.0,
          left: 40.0,
        ),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.295,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title, //'Verse of the day',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.18,
                      width: 300,
                      child: ScrollConfiguration(
                        behavior: MyCustomScrollBehavior()
                            .copyWith(overscroll: false),
                        child: SingleChildScrollView(
                          controller: ScrollController(),
                          child: Text(
                            widget.text,
                            style: TextStyle(

                                color: Colors.white
                                  .withOpacity(0.5),
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 32.0),
          ],
        ),
      ),
    );
  }

  _onSave() {
    debugPrint('favorite_border_outlined');
  }

  Future<void> _onShare() async {
    debugPrint('share_outlined');
    debugPrint(widget.text);
    await Share.share(widget.text.isEmpty ? 'Error!!' : widget.text,
        subject: widget.text.isEmpty ? 'Error!!' : widget.text);
  }
}
