import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_word_remeber/page/add_word_page.dart';
import 'package:flutter_word_remeber/page/home_page.dart';
import 'package:flutter_word_remeber/page/word_list_page.dart';
import 'custom_widget.dart';
import 'extentions.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      builder:EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var titleList = [{"title":"英语","table":"english"},{"title":"马来语","table":"malay"}];
  int _counter = 0;
  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp();
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  void _firebaseTest(){

  }

  Future<void> getAllDocuments() async {
    // 获取指定集合的引用，这里以 'users' 集合为例
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    // 自动生成 doc ID
    await firestore.collection("english").add({
      "key": "example9999",
      "value": "这是猜测",
      "note": "This is an example sentence.",
      "from": "上课",
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getElevatedButton(titleList.first["title"]??"",(){
                  context.navigateTo(HomePage(title: titleList.first["title"]??"", table: titleList?.first["table"]??""));
                }),
                Padding(padding: EdgeInsets.all(10)),
                getElevatedButton(titleList[1]["title"]??"",(){
                  context.navigateTo(HomePage(title: titleList[1]["title"]??"", table: titleList[1]["table"]??""));
                }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
