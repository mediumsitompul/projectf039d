import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login/score.dart';
import 'question.dart';
import 'score.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static const String _title = 'QUIZ ONLINE\n    (SCORE)';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: _title,
      home: Scaffold(
          appBar: AppBar(title: Center(child: Text(_title))),
          body: MyStatefulWidget()),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  var sum1;
  var sum2;

  var id1;

  var question;
  var aa;
  var bb;
  var cc;
  var dd;
  var answer;

  @override
  void initState() {
    // TODO: implement initState
    _queryCount();
    super.initState();
  }

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  Future<void> _queryCount() async {
    final url1 = Uri.parse(
      'http://192.168.100.240:8087/quiz/query_count.php',
    );
    var response = await http.post(url1, body: {});
    var datauser = jsonDecode(response.body);

    if (datauser.isEmpty) {
      setState(() {
        sum1 = "0";
      });
    } else {
      setState(() {
        sum1 = datauser[0]['jumlah'];
        sum2 = int.parse(sum1) + 1;

        if (sum2 == 11) {
          sum2 = "FINISHED";
        }
      });
    }
  }

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  Future<void> _queryQuestion() async {
    final url =
        Uri.parse('http://192.168.100.240:8087/quiz/query_question.php');
    var response = await http.post(url, body: {
      "number": sum2.toString(),
    });

    print(
        "sum2++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    print(sum2);

    var datauser = jsonDecode(response.body);

    if (datauser.isEmpty) {
      setState(() {});
    } else {
      if (datauser[0]['id'] != null) {
        id1 = datauser[0]['id'];
        question = datauser[0]['question'];
        aa = datauser[0]['aa'];
        bb = datauser[0]['bb'];
        cc = datauser[0]['cc'];
        dd = datauser[0]['dd'];
        answer = datauser[0]['answer'];

        //SEND PARAMETER DATA FIELD TO PAGE-2
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyProject(
                    id_: id1,
                    question_: question,
                    aa_: aa,
                    bb_: bb,
                    cc_: cc,
                    dd_: dd,
                    answer_: answer,
                  )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                sum2.toString(), //+++ QUERY +++
                style: const TextStyle(fontSize: 50),
              ),
            ),
          ],
        ),
        Container(
            height: 150,
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                ElevatedButton(
                  child: const Text(
                    'Query Question Number',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    _queryQuestion();
                  },
                ),
                const SizedBox(
                  height: 0,
                ),
                ElevatedButton(
                  child: const Text(
                    'SCORE  10  QUESTIONS',
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyScore()));
                  },
                ),
              ],
            )),
        Text(
          sum1.toString(),
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          sum2.toString(),
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
