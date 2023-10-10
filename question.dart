import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'main.dart';

class MyProject extends StatefulWidget {
  final String id_, question_, aa_, bb_, cc_, dd_, answer_;

  const MyProject({
    Key? key,
    required this.id_,
    required this.question_,
    required this.aa_,
    required this.bb_,
    required this.cc_,
    required this.dd_,
    required this.answer_,
  }) : super(key: key);

  @override
  State<MyProject> createState() => _MyProjectState();
}

TextEditingController idController = TextEditingController();
TextEditingController questionController = TextEditingController();
TextEditingController answerController = TextEditingController();
TextEditingController correctController = TextEditingController();

enum ANSWER { a, b, c, d, e }

ANSWER? _quiz = ANSWER.e; //e: Default Blank

class _MyProjectState extends State<MyProject> {
  var statusController;
  var m;

  Future<void> _select() async {
    final url = Uri.parse(
      'http://192.168.100.240:8087/quiz/save_answer.php',
    );

    if (_quiz.toString() == widget.answer_.toString()) {
      statusController = "TRUE"; //JAWABAN
    } else
      statusController = "FALSE"; //JAWABAN

    var response = await http.post(url, body: {
      "idController": widget.id_.toString(),
      "answerController": _quiz.toString(),
      "correctController": widget.answer_.toString(),
      "statusController": statusController.toString(),
    });
    final result1 = jsonDecode(response.body);

    if (result1.isNotEmpty) {
      print(result1); // Response from JSON File PHP
    }
  }

  //..........................................................................................................

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("QUIZ ONLINE")),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 50,
          ),
          Text("Question No. " + widget.id_,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 20)),
          const SizedBox(
            height: 20,
          ),
          Text(
            widget.question_,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          ListTile(
              title: Row(
                children: [
                  const Text("a.   "),
                  Expanded(child: Text(widget.aa_)),
                ],
              ),
              leading: Radio<ANSWER>(
                value: ANSWER.a,
                groupValue: _quiz,
                onChanged: (ANSWER? value) {
                  setState(() {
                    _quiz = value;
                    //controller: answerController.toString();
                  });
                },
              )),

          //......................................................
          ListTile(
              title: Row(
                children: [
                  const Text("b.   "),
                  Expanded(child: Text(widget.bb_)),
                ],
              ),
              leading: Radio<ANSWER>(
                value: ANSWER.b,
                groupValue: _quiz,
                onChanged: (ANSWER? value) {
                  setState(() {
                    _quiz = value;
                    //opsys.text = _quiz.toString();
                    //controller: answerController.toString();
                  });
                },
              )),
          //......................................................
          ListTile(
              title: Row(
                children: [
                  const Text("c.   "),
                  Expanded(child: Text(widget.cc_)),
                ],
              ),
              leading: Radio<ANSWER>(
                value: ANSWER.c,
                groupValue: _quiz,
                onChanged: (ANSWER? value) {
                  setState(() {
                    _quiz = value;
                    //opsys.text = _quiz.toString();
                    //controller: answerController.toString();
                  });
                },
              )),
          //......................................................
          ListTile(
              title: Row(
                children: [
                  const Text("d.   "),
                  Expanded(
                    child: Text(
                      widget.dd_,
                    ),
                  ),
                ],
              ),
              leading: Radio<ANSWER>(
                value: ANSWER.d,
                groupValue: _quiz,
                onChanged: (ANSWER? value) {
                  setState(() {
                    _quiz = value;
                    //controller: answerController.toString();
                  });
                },
              )),
          //......................................................

          const SizedBox(
            height: 20,
          ),

          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(80, 2, 80, 2),
            child: ElevatedButton(
                onPressed: () {
                  _select();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp()),
                  );
                  setState(() {
                    _quiz = ANSWER.e; //reset radio button
                  });
                },
                child: const Text('E N T E R')),
          )
        ],
      ),
    );
  }
}
