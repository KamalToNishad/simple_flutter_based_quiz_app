import 'question_class.dart';

class QuestionMaterial {
  //initialization of starting question number
  int _questionNumber = 0;

  //Privet List of questions
  List<Questions> _questionList = [
    Questions(q: 'Delhi is Capital of India', a: true),
    Questions(q: 'Pedro Pascal is a singer, not actor', a: false),
    Questions(q: 'There is no life on Earth without Sun', a: true)
  ];

//Method to move to the next question
  void goToNextQuestion() {
    if (_questionNumber < _questionList.length - 1) {
      _questionNumber++;
    }
  }

  //Method to get the question
  String getQuestion() {
    return _questionList[_questionNumber].question;
  }

  //Method to return actual answer of the question
  bool getActualAns() {
    return _questionList[_questionNumber].answer;
  }

  bool isFinished() {
    if (_questionNumber >= _questionList.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }
}
