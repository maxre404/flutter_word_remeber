import 'package:flutter/material.dart';
import 'package:flutter_word_remeber/custom_widget.dart';

class LearnSubPage extends StatefulWidget {
  String title;
  String table = "";
  Map<String, dynamic> learnWord;

  LearnSubPage({
    super.key,
    required this.title,
    required this.table,
    required this.learnWord,
  });

  @override
  State<LearnSubPage> createState() => _LearnSubPageState();
}

class _LearnSubPageState extends State<LearnSubPage> {
  var isShowResult = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${widget.learnWord["key"]}",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Padding(padding: EdgeInsets.all(20)),
          if (!isShowResult)getElevatedButton("显示结果", () {
              isShowResult = true;
              setState(() {});
            }),
          if(isShowResult)...[
            Text("单词意思:${widget.learnWord["value"]}",style: TextStyle(color: Colors.redAccent,fontWeight: FontWeight.bold),),
            Padding(padding: EdgeInsets.all(20)),
            Text("单词备注:${widget.learnWord["note"]}"),
            Padding(padding: EdgeInsets.all(20)),
            Text("单词来源:${widget.learnWord["from"]}"),
          ]
        ],
      ),
    );
  }
}
