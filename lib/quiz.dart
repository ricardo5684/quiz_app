import 'package:flutter/material.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';
class Quiz extends StatefulWidget {
  const Quiz({super.key});
  @override
  State<StatefulWidget> createState() {
    return _QuizState();
  }
}
class _QuizState extends State<Quiz> {
  var activeScreen = 'start-screen';
  List<String> selectedAnswers = [];
 void switchScreen() {
    setState(() {
      activeScreen = 'quiz-screen';
    });
  }
  void chooseAnswer(String answer){
     selectedAnswers.add(answer);
     if(selectedAnswers.length == questions.length){
      setState(() {
        activeScreen = 'result-screen';
      });
     }
  }
  void restart(){
    setState(() {
      selectedAnswers = [];
      activeScreen = 'quiz-screen';
    });
  }
  void exit(){
    setState(() {
      activeScreen = 'start-screen';
    });
  }
  @override
  Widget build(BuildContext context) {
    Widget screenWidget = StartScreen(switchScreen);
     if(activeScreen == 'quiz-screen'){
      screenWidget = QuestionsScreen(onSelectAnswer: chooseAnswer);
     }
     if(activeScreen == 'result-screen' ){
       screenWidget = ResultsScreen(chooseAnswer: selectedAnswers,onRestart: restart,onExit: exit);
     }
    return MaterialApp(
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(100, 40, 1, 250),
          Color.fromARGB(200, 100, 10, 30)
        ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child:
        screenWidget
       )),
    );
  }
}