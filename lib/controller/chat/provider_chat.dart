import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quel_prof/widgets/chat_page/chat_box.dart';

class ProviderChat extends ChangeNotifier {
  ///Fields
  bool _isDisposed = false;
  bool _isLoading = false;
  ScrollController _scrollController = ScrollController();
  TextEditingController _textEditingController = TextEditingController();

  ///Stream
  // bool _isLoading = false;
  Stream<List<ChatBox>>? _stream; // The stream
  late StreamSubscription? _subStream; // To control the stream
  List<ChatBox> _children = <ChatBox>[];

  ///Getters & Setters
  List<Widget> get children => _children;

  bool get isLoading => _isLoading;

  ScrollController get scrollController => _scrollController;

  TextEditingController get textEditingController => _textEditingController;

  ///Overrides
  // @override
  // dispose() {
  //   _isDisposed = true;
  //   super.dispose();
  // }

  ///methods

  Future<void> onInitState(BuildContext context) async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
        Navigator.pushNamedAndRemoveUntil(
            context, '/FirstPage', (route) => false);
      } else {
        _openStream(context, user.uid);
      }
    });
  }

  void _openStream(BuildContext context, String uid) {
    debugPrint('User is signed in!');
    debugPrint('Stream Open!');
    _stream = _loadChatFromFireBase(context, uid).asBroadcastStream();
    _subStream = _stream?.listen((event) async {
      try {
        _children = event;
        _isLoading = false;
        // await scrollDown();
        notifyListeners();
        return;
      } catch (e) {
        _children = [];
        _children = [];
        _isLoading = false;
        notifyListeners();
        return;
      }
    });
  }

  Stream<List<ChatBox>> _loadChatFromFireBase(
      BuildContext context, String uid) async* {
    // var account_Id = await SessionManager().get('account_Id');
    // var user_uni = await SessionManager().get('user_uni');
    yield* FirebaseFirestore.instance
        .collection('chat')
        .where('chatId', isEqualTo: uid)
        .orderBy("messageDate", descending: false)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (DocumentSnapshot documentSnapshot) {
                debugPrint(documentSnapshot.id);
                debugPrint(documentSnapshot.data().toString());

                if (documentSnapshot.get('accountId') == uid) {
                  return ChatBox(
                    message: documentSnapshot.get('messageData'),
                    // imageURL:
                    //     "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                    //Receiving GIF or Image
                    recieved: false,
                    chatBoxColor:
                        Theme.of(context).primaryColor.withOpacity(0.3),
                    textColor: Colors.white,
                    time: DateFormat('HH:mm')
                        .format(documentSnapshot.get('messageDate').toDate())
                        .toString(),
                  );
                }
                return
                    // Row(
                    // children: [
                    // children == [] ||
                    //     snapShotData[index - 1]
                    //     ['accountId'] !=
                    //         snapShotData[index]['accountId']
                    //     ? Container(
                    //     width: 73,
                    //     padding: const EdgeInsets.only(
                    //         top: 10, left: 10),
                    //     child: Column(
                    //       children: [
                    //         CircleAvatar(
                    //           backgroundColor: Theme.of(context).primaryColor,
                    //           child: Text(
                    //             snapShotData[index]
                    //             ['accountName'][0]
                    //                 .toString()
                    //                 .toUpperCase(),
                    //             style: const TextStyle(
                    //                 color: Colors.white),
                    //           ),
                    //         ),
                    //         const SizedBox(height: 2.0),
                    //         Text(
                    //           snapShotData[index]
                    //           ['accountName'],
                    //           style: const TextStyle(
                    //               color: Colors.white),
                    //         ),
                    //       ],
                    //     ))
                    //     : const SizedBox(width: 73),
                    ChatBox(
                  message: documentSnapshot.get('messageData'),
                  // imageURL:
                  //     "https://docs.flutter.dev/assets/images/dash/dash-fainting.gif",
                  //Receiving GIF or Image
                  recieved: true,
                  chatBoxColor: Theme.of(context).primaryColor.withOpacity(0.5),
                  textColor: Colors.white,
                  time: DateFormat('HH:mm')
                      .format(documentSnapshot.get('messageDate').toDate())
                      .toString(),
                );
                // ],
                // );
              },
            ).toList());
  }

  Future<void> sendMessage(BuildContext context) async {
    if(_textEditingController.text.isEmpty){
      return;
    }
    FirebaseAuth.instance.userChanges().listen((User? user) async {
      if (user == null) {
        debugPrint('User is currently signed out!');
        Navigator.pushNamedAndRemoveUntil(
            context, '/FirstPage', (route) => false);
      } else {
        Map<String, dynamic> data = {
          // "account": account_Id,
          "chatId": user.uid,
          "accountId": user.uid,
          "accountName": user.email,
          "messageData": _textEditingController.text,
          "messageDate": DateTime.now()
        };

        _textEditingController.clear();
        await FirebaseFirestore.instance.collection("chat").add(data).then(
            (documentSnapshot) {
                debugPrint("Added message with ID: ${documentSnapshot.id}");
            });
        // _textEditingController.clear();
      }
    });
  }

  // Future<void> scrollDown() async {
  //   while (!_scrollController.hasClients) {
  //     // _isListViewBuilded != true
  //     print('await');
  //     await Future.delayed(const Duration(milliseconds: 100));
  //   }
  //   // Future.delayed(Duration.zero, () async {
  //   // });
  //
  //   print('!await');
  //   _scrollController.jumpTo(_scrollController.position.maxScrollExtent * 3);
  //   // notifyListeners();
  //   // await _scrollController.animateTo(_scrollController.position.maxScrollExtent * 2,
  //   //     duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
  // }
}
