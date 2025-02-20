import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_word_remeber/extentions.dart';
import 'package:flutter_word_remeber/custom_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddWordPage extends StatefulWidget {
  String title;
  String table = "";

  AddWordPage({super.key, required this.title, required this.table});

  @override
  State<AddWordPage> createState() => _AddWordPageState();
}

class _AddWordPageState extends State<AddWordPage> {
  final TextEditingController _wordController = TextEditingController();
  final TextEditingController _translateController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 等待 UI 构建完成后再请求焦点
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void submit() async {
    var inputWord = _wordController.text;
    var inputTranslate = _translateController.text;
    var inputNote = _noteController.text;
    var inputFrom = _fromController.text;
    if (inputWord.isEmpty) {
      EasyLoading.showToast("单词输入框不能为空");
      // Fluttertoast.showToast(msg: "单词输入框不能为空",gravity: ToastGravity.BOTTOM);
      return;
    }
    if (inputTranslate.isEmpty) {
      EasyLoading.showToast("翻译输入框不能为空");
      return;
    }
    EasyLoading.show(status: '加载中...');
    // 获取指定集合的引用，这里以 'users' 集合为例
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 自动生成 doc ID
    await firestore.collection(widget.table).add({
      "key": inputWord,
      "value": inputTranslate,
      "note": inputNote,
      "from": inputFrom,
    });
    EasyLoading.dismiss();
    EasyLoading.showToast("设置成功");
    context.navigateBack();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                getTextField("单词", "请输入将要记录的单词", _wordController),
                Padding(padding: EdgeInsets.all(10)),
                getTextField("翻译", "请输入单词意思", _translateController),
                Padding(padding: EdgeInsets.all(10)),
                getTextField("备注", "请输入备注", _noteController),
                Padding(padding: EdgeInsets.all(10)),
                getTextField("来源", "请输入这个单词的来源", _fromController),
                Padding(padding: EdgeInsets.all(10)),
                getElevatedButton("提交", () => {submit()}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
