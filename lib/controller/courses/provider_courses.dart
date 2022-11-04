import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quel_prof/widgets/calendar_page/course_item.dart';

class ProviderCourses extends ChangeNotifier {
  ///Fields
  bool _isDisposed = false;
  bool _isLoading = false;

  ///Stream
  // bool _isLoading = false;
  Stream<List<CourseItem>>? _stream; // The stream
  late StreamSubscription? _subStream; // To control the stream
  List<CourseItem> _courses = <CourseItem>[];

  ///Getters & Setters
  List<CourseItem> get courses => _courses;

  ///Overrides
  @override
  dispose() {
    _isDisposed = true;
    super.dispose();
  }

  ///methods

  Future<void> onInitState(BuildContext context) async {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
        Navigator.pushNamedAndRemoveUntil(
            context, '/FirstPage', (route) => false);
      } else {
        _openStream(user.uid);
      }
    });
  }

  void _openStream(String uid) {
    debugPrint('User is signed in!');
    debugPrint('Stream Open!');
    _stream = _loadCoursesFromFireBase(uid).asBroadcastStream();
    _subStream = _stream?.listen((event) {
      try {
        _courses = event;
        _isLoading = false;
        notifyListeners();
        return;
      } catch (e) {
        _courses = [];
        _isLoading = false;
        notifyListeners();
        return;
      }
    });
  }

  Stream<List<CourseItem>> _loadCoursesFromFireBase(String uid) async* {
    // var account_Id = await SessionManager().get('account_Id');
    // var user_uni = await SessionManager().get('user_uni');
    yield* FirebaseFirestore.instance
        .collection('courses')
        .where('userId', isEqualTo: uid)
        // .orderBy("createdAt", descending: true)
        // .limit(_getNbr)
        .snapshots()
        .map((QuerySnapshot querySnapshot) => querySnapshot.docs.map(
              (DocumentSnapshot documentSnapshot) {
                debugPrint(documentSnapshot.id);
                return CourseItem(
                    courseId: documentSnapshot.id,
                    courseName: documentSnapshot.get('courseName'),
                    date: documentSnapshot.get('courseDate').toDate());
              },
            ).toList());
  }
}
