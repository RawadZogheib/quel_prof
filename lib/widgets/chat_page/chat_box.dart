import 'package:any_link_preview/any_link_preview.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatBox extends StatefulWidget {
  const ChatBox({
    Key? key,
    this.message = "",
    required this.recieved,
    required this.chatBoxColor,
    this.textColor = Colors.black,
    this.imageURL = "",
    this.doculink = "",
    required this.time,
  }) : super(key: key);

  final String message;
  final bool recieved;
  final Color chatBoxColor;
  final Color textColor;
  final String imageURL;
  final String time;
  final String doculink;

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  bool _recieved = true;
  String _message = "No message was sent";
  Color _chatBoxColor = Colors.greenAccent;
  Color _textColor = Colors.greenAccent;
  String _imageURL = "";
  String time = "";
  String doculink = "";
  String docuname = "";
  bool checknetwork = false;

  final now = DateTime.now();

  void checkconnection() async {
    try {
      final response = await http.get(Uri.parse(_imageURL));
      if (response.statusCode == 200) {
        setState(() {
          checknetwork = true;
        });
      } else {
        setState(() {
          checknetwork = false;
        });
      }
    } catch (e) {
      //print(e);
    }
  }

  void verifyconditions() {
    if (_imageURL == "" && _message == "") {
      setState(() {
        _message = "Nothing to display";
      });
    } else if (_message == "") {
      setState(() {
        _message = " ";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _recieved = widget.recieved;
    _message = widget.message;
    _chatBoxColor = widget.chatBoxColor;
    _textColor = widget.textColor;
    _imageURL = widget.imageURL;
    time = widget.time;
    doculink = widget.doculink;
    if (_imageURL != "") {
      checkconnection();
    }
    if (doculink != "") {
      getname();
    }
    verifyconditions();
  }

  void getname() {
    var filename = doculink.split('/').last;
    String s = "";
    for (int i = 0; i < filename.length; i++) {
      if (filename[i] == "?") {
        break;
      }
      s = s + filename[i];
    }
    setState(() {
      docuname = s;
    });
    // print(s);
  }

  Future openlink() async {
    await launchUrl(Uri.parse(doculink));
    //final taskid = await Flu
  }

  @override
  Widget build(BuildContext context) {
    return _recieved == true
        ? Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 10),
        child: Container(
          // width: 250,
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 2 / 3,
            minWidth: MediaQuery.of(context).size.width / 4,
            minHeight: MediaQuery.of(context).size.height / 15,
          ),
          decoration: BoxDecoration(
            color: _chatBoxColor,
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: doculink != ""
              ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black45.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Expanded(
                        flex: 1,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.insert_drive_file_rounded,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 9,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            docuname,
                            style: const TextStyle(fontSize: 15),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    time,
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          )
              : Padding(
              padding: const EdgeInsets.all(5.0),
              child: _imageURL != ""
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: !checknetwork
                        ? Image.asset(
                      "packages/chatbox/assets/loading.gif",
                      height: 10,
                    )
                        : Image.network(_imageURL,
                        loadingBuilder:
                            (BuildContext context,
                            Widget child,
                            ImageChunkEvent?
                            loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: 100,
                            child: Center(
                              child:
                              CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        }),
                  ),
                  TextBox(
                    message: _message,
                    textColor: _textColor,
                    time: time,
                  )
                ],
              )
                  : TextBox(
                message: _message,
                textColor: _textColor,
                time: time,
              )),
        ),
      ),
    )
        : Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 120, right: 10),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 2 / 3,
            minWidth: MediaQuery.of(context).size.width / 5,
            minHeight: MediaQuery.of(context).size.height / 15,
          ),
          decoration: BoxDecoration(
            color: _chatBoxColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          child: doculink != ""
              ? Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    openlink();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black45.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.insert_drive_file_rounded,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 9,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              docuname,
                              style: const TextStyle(fontSize: 15),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    time,
                    textAlign: TextAlign.right,
                  ),
                )
              ],
            ),
          )
              : Padding(
              padding: const EdgeInsets.all(5.0),
              child: _imageURL != ""
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: !checknetwork
                        ? Image.asset(
                      "packages/chatbox/assets/loading.gif",
                      height: 10,
                    )
                        : Image.network(_imageURL,
                        loadingBuilder:
                            (BuildContext context,
                            Widget child,
                            ImageChunkEvent?
                            loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return SizedBox(
                            height: 100,
                            child: Center(
                              child:
                              CircularProgressIndicator(
                                value: loadingProgress
                                    .expectedTotalBytes !=
                                    null
                                    ? loadingProgress
                                    .cumulativeBytesLoaded /
                                    loadingProgress
                                        .expectedTotalBytes!
                                    : null,
                              ),
                            ),
                          );
                        }),
                  ),
                  TextBox(
                    message: _message,
                    textColor: _textColor,
                    time: time,
                  )
                ],
              )
                  : TextBox(
                message: _message,
                textColor: _textColor,
                time: time,
              )),
        ),
      ),
    );
  }
}

class TextBox extends StatefulWidget {
  const TextBox({
    Key? key,
    required String message,
    required Color textColor,
    required this.time,
  })  : _message = message,
        _textColor = textColor,
        super(key: key);

  final String _message;
  final Color _textColor;
  final String time;

  @override
  State<TextBox> createState() => _TextBoxState();
}

class _TextBoxState extends State<TextBox> {
  String url = "";

  @override
  Widget build(BuildContext context) {
    final matcher = RegExp(
        r"(http(s)?:\/\/.)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");

    if (matcher.stringMatch(widget._message) != null) {
      setState(() {
        url = matcher.stringMatch(widget._message).toString();
      });
    }

    return url != ""
        ? Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnyLinkPreview(
          link: url,
          cache: const Duration(hours: 1),
          displayDirection: UIDirection.uiDirectionHorizontal,
          backgroundColor: Colors.white,
          onTap: () {
            launchUrl(Uri.parse(url));
          },
        ),
        RichText(
          text: TextSpan(
            text: widget._message != "" ? "${widget._message}\n" : "\n",
            style: TextStyle(
              color: widget._textColor,
              fontWeight: FontWeight.bold,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: widget.time,
                  //"${(widget.now.hour).toString().padLeft(2, "0")}:${(widget.now.minute).toString().padLeft(2, "0")}",
                  style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.w500,
                  )),
            ],
          ),
        ),
      ],
    )
        : RichText(
      text: TextSpan(
        text: widget._message != "" ? "${widget._message}\n" : "\n",
        style: TextStyle(
          color: widget._textColor,
          fontWeight: FontWeight.bold,
        ),
        children: <TextSpan>[
          TextSpan(
              text: widget.time,
              //"${(widget.now.hour).toString().padLeft(2, "0")}:${(widget.now.minute).toString().padLeft(2, "0")}",
              style: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }
}
