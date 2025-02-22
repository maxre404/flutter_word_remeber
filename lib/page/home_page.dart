import 'package:flutter/material.dart';
import 'package:flutter_word_remeber/custom_widget.dart';
import 'package:flutter_word_remeber/extentions.dart';
import 'package:flutter_word_remeber/page/add_word_page.dart';
import 'package:flutter_word_remeber/page/learn_page.dart';
import 'package:flutter_word_remeber/page/word_list_page.dart';

class HomePage extends StatefulWidget {
  String title;
  String table = "";

   HomePage({super.key,required this.title, required this.table});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            getElevatedButton("添加词库", (){
              context.navigateTo(AddWordPage(title: widget.title, table: widget.table));

            }),
            Padding(padding: EdgeInsets.all(10)),
            getElevatedButton("开始学习", (){
              context.navigateTo(LearnPage(title: widget.title, table: widget.table));
            }),
            Padding(padding: EdgeInsets.all(10)),
            getElevatedButton("查看词库", (){
            context.navigateTo(WordListPage(title: widget.title, table: widget.table));
            }),
          ],
        ),
      ),
    );
  }
}
