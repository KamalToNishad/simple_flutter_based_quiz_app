import 'package:flutter/material.dart';
import 'package:simple_flutter_based_quiz_app/question_material.dart';
import 'package:quickalert/quickalert.dart';

void main() {
  runApp(const Quiz());
}

QuestionMaterial questionMaterial = QuestionMaterial();

class Quiz extends StatelessWidget {
  const Quiz({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizBody(),
          ),
        ),
      ),
    );
  }
}

//Quiz Screen Body

class QuizBody extends StatefulWidget {
  const QuizBody({Key? key}) : super(key: key);

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  //List to store user result in icon form

  List<Icon> userResult = [];

  //Function to validate user answer with actual answer
  //if question is correct add check icon to list else add cross icon
  void validateAns(bool userAns) {
    if (questionMaterial.getActualAns() == userAns) {
      userResult.add(const Icon(
        Icons.check,
        color: Colors.green,
      ));
    } else {
      userResult.add(const Icon(
        Icons.close,
        color: Colors.red,
      ));
    }
  }

  //Function to check if quiz finished or not if not then perform
  // validation else show the result and reset the state of the quiz
  void checkAns(bool userAns) {
//
    if (questionMaterial.isFinished()) {
      //Alert widget to show result at the end of quiz
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'End of the quiz',
        text: 'Your Result',
        confirmBtnColor: Colors.amber,
        widget: Row(
          children: userResult,
        ),
        barrierColor: Colors.white,
      );
      validateAns(userAns);
      //Reset Quiz Screen when quiz is finished
      setState(() {
        questionMaterial.reset();
        userResult = [];
      });
    } else {
      validateAns(userAns);
      //Go to next question if quiz not finished and render it on display
      setState(() {
        questionMaterial.goToNextQuestion();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        //Widget for question display
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionMaterial.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),

        //Widget for True button
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Colors.amber,
              child: const Text(
                'True',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
              onPressed: () {
                checkAns(true);
              },
            ),
          ),
        ),

        //Widget for false button
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: MaterialButton(
              color: Colors.amber,
              child: const Text(
                'False',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w300),
              ),
              onPressed: () {
                checkAns(false);
              },
            ),
          ),
        ),

        //It will show realtime result after answering every question
        Row(
          children: userResult,
        )
      ],
    );
  }
}
