import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/questions_summary.dart';
class ResultsScreen extends StatelessWidget {
  const ResultsScreen ({super.key , required this.chooseAnswer, required this.onRestart,required this.onExit});
  final List<String> chooseAnswer;
  final void Function() onRestart;
  final void Function() onExit;
  List<Map<String, Object>> getSummaryData(){
    final List<Map<String, Object>> summary = [];
    for(var i = 0 ; i < chooseAnswer.length ; i++){
      summary.add({
         'question_index' : i ,
         'question' : questions[i].text,
         'correct_answer' : questions[i].answers[0],
         'user_answer' : chooseAnswer[i]
      });
    }
    return summary;
  }
  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData.where((data){
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(60),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              'Your answer $numCorrectQuestions out of $numTotalQuestions questions correctly!',
              style: GoogleFonts.ubuntu(
                color: Color.fromARGB(255, 81, 255, 0),
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30,),
            QuestionsSummary(summaryData: getSummaryData()),
            const SizedBox(height: 30),
            TextButton(onPressed: onRestart,
             child: const Text('Restart Quiz',
             style: TextStyle(
              color: Colors.white
             ),),
             ),
             const SizedBox(height: 20,),
             ElevatedButton(
              onPressed: onExit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white
              ),
              child: const Text('Exit'),)
          ]),
      ),
    );
  }
}






