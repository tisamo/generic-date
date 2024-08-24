import 'package:flutter/material.dart';
import 'package:generic_date/shared/elements/colored_button.dart';
import 'package:generic_date/shared/styles/button_style.dart';
import 'package:generic_date/shared/styles/colors.dart';

import '../../shared/styles/text_styles.dart';

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestionIndex = 0;
  bool quizEnded = false;
  String? infp;

  List<Map<String, dynamic>> quiz = [
    {
      'title': 'Élvezem, ha nagy csoportokban tölthetem az időmet.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'E/I' // Extraversion / Introversion
    },
    {
      'title': 'Feladatokban a részletekre és a gyakorlatias megoldásokra fókuszálok.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'S/N' // Sensing / Intuition
    },
    {
      'title': 'Döntéseket inkább logikai megfontolás alapján hozok, mintsem érzelmekre alapozva.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'T/F' // Thinking / Feeling
    },
    {
      'title': 'Előnyben részesítem a struktúrált napirendet, ahelyett, hogy a dolgok áramlására hagyatkoznék.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'J/P' // Judging / Perceiving
    },
    {
      'title': 'Egyedül töltött idő után érzem magam feltöltődve.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'E/I' // Extraversion / Introversion
    },
    {
      'title': 'Gyakran a jövőbeli lehetőségeken gondolkodom, ahelyett, hogy a jelenre koncentrálnék.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'S/N' // Sensing / Intuition
    },
    {
      'title': 'Ha nehéz döntéssel szembesülök, inkább az érzéseimre támaszkodom, mint a logikára.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'T/F' // Thinking / Feeling
    },
    {
      'title': 'Szeretem nyitva hagyni a lehetőségeimet, és spontán módon hozni döntéseket.',
      'answers': ['1', '2', '3', '4', '5', '6', '7'], // 1 = Egyáltalán nem, 7 = Teljesen egyetértek
      'type': 'J/P' // Judging / Perceiving
    }
  ];

  List<String> selectedQuestions = [];

  // Function to handle user's answer submission
  void checkAnswer(String selectedAnswer) {
    moveToNextQuestion();
  }

  @override
  void initState() {
    selectedQuestions = List.filled(quiz.length, '');
    super.initState();
  }

  // Function to move to the next question
  void moveToNextQuestion() {
    setState(() {
      if (currentQuestionIndex < quiz.length - 1) {
        currentQuestionIndex++;
      } else {
        quizEnded = true;
      }
    });
  }

  double calculateButtonSize(int index) {
    int totalButtons = 7;
    int medianIndex = 3;
    double maxSize = 50.0;

    if (index <= medianIndex) {
      return maxSize - (index * 4.0);
    } else {
      return maxSize - ((totalButtons - index - 1) * 4.0);
    }
  }
    void calculateINFP(List<Map<String, dynamic>> quiz, List<String?> selectedQuestions) {
      int introversion = 0;
      int extraversion = 0;
      int intuition = 0;
      int sensing = 0;
      int feeling = 0;
      int thinking = 0;
      int perceiving = 0;
      int judging = 0;

      for (int i = 0; i < quiz.length; i++) {
        if (selectedQuestions[i] == null) continue;

        var question = quiz[i];
        var answer = int.parse(selectedQuestions[i]!);
        var type = question['type'] as String;

        switch (type) {
          case 'E/I':
            if (answer >= 4) {
              extraversion++;
            } else {
              introversion++;
            }
            break;
          case 'S/N':
            if (answer >= 4) {
              intuition++;
            } else {
              sensing++;
            }
            break;
          case 'T/F':
            if (answer >= 4) {
              feeling++;
            } else {
              thinking++;
            }
            break;
          case 'J/P':
            if (answer >= 4) {
              perceiving++;
            } else {
              judging++;
            }
            break;
        }
      String result = '';
      result += introversion > extraversion ? 'I' : 'E';
      result += intuition > sensing ? 'N' : 'S';
      result += feeling > thinking ? 'F' : 'T';
      result += perceiving > judging ? 'P' : 'J';
      setState(() {
        infp = result;
      });
      Navigator.pushNamed(context, '/test-result/$result');
    }
      return null;
  }

  Color selectColorBasedOnIndex(int index) {
    int medianIndex = 3;
    late Color color;
    if (index == medianIndex) {
      color = Colors.grey;
    } else if (index > medianIndex) {
      return ColorTheme.secondaryColor;
    } else {
      return ColorTheme.primaryColor;
    }
    return color;
  }

  Color isIndexSelected(int index) {

    bool answer = quiz[currentQuestionIndex]['answers'][index] == selectedQuestions[currentQuestionIndex];
    if (!answer) {
      return Colors.white;
    }
    if (index == 3) {
      return Colors.grey;
    } else if (index < 3) {
      return ColorTheme.primaryColor;
    } else {
      return ColorTheme.secondaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hideNextButton = (currentQuestionIndex + 1) == quiz.length;
    bool hidePrevButton = currentQuestionIndex == 0;
    bool quizFilled = !selectedQuestions.any((q) => q == '');
    return Scaffold(
        appBar: AppBar(
          title: const Text('Personality Test'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 75),
            child: Column(
              children: [
                        Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            textAlign: TextAlign.center,
                              quiz[currentQuestionIndex]['title'],
                              style: const TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                                              
                                                ),
                        ),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...((quiz[currentQuestionIndex]['answers']
                                  as List<String>)
                              .asMap()
                              .map((index, answer) {
                            double size = calculateButtonSize(index);
                            return MapEntry(
                              index,
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                // spacing between buttons
                                child: MaterialButton(
                                    onPressed: () {
                                      setState(() {
                                        selectedQuestions[currentQuestionIndex] = answer;
                                      });
                                    },
                                    color: isIndexSelected(index),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: BorderSide(
                                          color: selectColorBasedOnIndex(index),
                                          width: 2.0),
                                    ),
                                    minWidth: size,
                                    height: size,
                                    child: const Icon(Icons.check,
                                        color: Colors.white)),
                              ),
                            );
                          })).values.toList(),
                        ],
                      ),
                      const Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: SizedBox(
                            width: 330,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Agree',
                                  style: TextStyle(
                                      color: ColorTheme.primaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  'Disagree',
                                  style: TextStyle(
                                      color: ColorTheme.secondaryColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                )
                              ],
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Previous Button
                            Opacity(
                                opacity: hidePrevButton ? 0.0 : 1.0,
                                child: IgnorePointer(
                                    ignoring: hidePrevButton,
                                    child: TextButton(
                                      onPressed: () {
                                        if (currentQuestionIndex != 0) {
                                          setState(() {
                                            currentQuestionIndex--;
                                          });
                                        }
                                      },
                                      child: Text('Previous',
                                          style: ThemeText.textButtonStyle(color: ColorTheme.secondaryColor)),
                                    ))),
                            // Spacing between buttons
                            const SizedBox(width: 30),
                            Opacity(
                                opacity: hideNextButton ? 0.0 : 1.0,
                                child: IgnorePointer(
                                    ignoring: hideNextButton,
                                    child: TextButton(
                                      onPressed: () {
                                        print('kek');

                                        if ((currentQuestionIndex + 1) !=
                                            quiz.length) {
                                          setState(() {
                                            currentQuestionIndex++;
                                          });
                                        }
                                      },
                                      child: Text('Next',
                                          style: ThemeText.textButtonStyle(color: ColorTheme.primaryColor)),
                                    ))),
                          ],
                        ),
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 70),
                          child: Opacity(
                              opacity: quizFilled ? 1.0 : 0.3,
                              child: IgnorePointer(
                                  ignoring: false,
                                  child: ColoredButton(
                                    color: ColorTheme.secondaryColor,
                                    buttonFunction: (){
                                      calculateINFP(quiz, selectedQuestions);
                                    },
                                    label: 'Finalize',
                                  ))),
                        ),
                      ),
                    ]
            ),
          ),
        ));
  }
}
