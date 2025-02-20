import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_word_remeber/extentions.dart';

import '../custom_widget.dart';

class WordListPage extends StatefulWidget {
  String title;
  String table = "";

  WordListPage({super.key, required this.title, required this.table});

  @override
  State<WordListPage> createState() => _WordListPageState();
}

class _WordListPageState extends State<WordListPage> {
  List<Map<String, dynamic>> allWordList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    refreshWord();
  }

  Future<List<Map<String, dynamic>>> getAllDocuments(
    String collectionPath,
  ) async {
    allWordList.clear();
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection(collectionPath).get();
    for (var doc in querySnapshot.docs) {
      // allWordList.add(doc.data() as Map<String, dynamic>);
      String documentId = doc.id;
      allWordList.add({...doc.data() as Map<String, dynamic>, 'id': documentId});
    }
    return allWordList;
  }

  refreshWord() async {
    EasyLoading.show();
    await getAllDocuments(widget.table);
    setState(() {});
    EasyLoading.dismiss();
  }

  void _showCupertinoConfirmDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext ctx) {
        return CupertinoAlertDialog(
            title: const Text('请确认'),
            content: const Text('你确定要执行此操作吗？'),
            actions: [
              // 取消按钮
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('取消'),
              ),
              // 确认按钮
              CupertinoDialogAction(
                onPressed: () {
                  // 执行确认后的操作，比如打印日志
                  Navigator.of(context).pop();
                },
                child: const Text('确认'),
              ),
            ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: allWordList.length,
        itemBuilder: (context, index) {
         var data = allWordList[index];
          return Padding(padding: EdgeInsets.all(15), child: Row(children: [
            Text("${data["key"]}"),
            Spacer(),
            getElevatedButton("删除", ()=>{
              _showCupertinoConfirmDialog(context)
            })

          ]));
        },
      ),
    );
  }
}
