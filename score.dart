import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class MyScore extends StatelessWidget {
  const MyScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Center(child: Text("QUIZ SCORE")),
        ),
        body: MyScores(),

      ),
    );
  }
}


class MyScores extends StatefulWidget {
  const MyScores({Key? key}) : super(key: key);

  @override
  State<MyScores> createState() => _MyScoresState();
}

class _MyScoresState extends State<MyScores> {

  final Uri _url = Uri.parse("http://192.168.100.240:8087/quiz/index.php");
  
  Future<void> _launchUrl() async{
    if(!await launchUrl(_url)){
      throw 'Could not launch $_url';
    }else{
      launchUrl(_url);
    }

  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      ElevatedButton(onPressed: (){
        _launchUrl();
      }, child: const Center(child: Text("CLICK HERE"))),
    );
  }
}
