import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_word_remeber/page/learn_sub_page.dart';

class LearnPage extends StatefulWidget {
  String title;
  String table = "";

  LearnPage({super.key, required this.title, required this.table});

  @override
  State<LearnPage> createState() => _LearnPageState();
}

class _LearnPageState extends State<LearnPage> {
  List<Map<String, dynamic>> allWordList = [];

  Future<List<Map<String, dynamic>>> getAllDocuments(
    String collectionPath,
  ) async {
    allWordList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();
    for (var doc in querySnapshot.docs) {
      // allWordList.add(doc.data() as Map<String, dynamic>);
      String documentId = doc.id;
      allWordList.add({
        ...doc.data() as Map<String, dynamic>,
        'id': documentId,
      });
    }
    allWordList.shuffle(Random());//随机打乱顺序
    return allWordList;
  }

  @override
  void initState() {
    refreshWord();
    super.initState();
  }

  void refreshWord() async {
    EasyLoading.show();
    await getAllDocuments(widget.table);
    setState(() {});
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(""),
      ),
      body: PageView.builder(
        physics: AlwaysScrollableScrollPhysics(), // 强制可滑动
        scrollDirection: Axis.vertical,
        itemCount: allWordList.length,
        itemBuilder: (context, index) {
          var data = allWordList[index];
          return LearnSubPage(
            title: widget.title,
            table: widget.table,
            learnWord: data,
          );
        },
      ),
    );
  }
}
