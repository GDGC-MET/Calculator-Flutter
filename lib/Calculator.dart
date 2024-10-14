import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userInput = '';
  var result = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white, // Background color
        body: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(result.toString(), style: TextStyle(fontSize: 50, color: Colors.blueAccent)), // Result text color
                      ),
                      Text(userInput.toString(), style: TextStyle(fontSize: 50, color: Colors.black)), // User input color
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(title: "C", onPress: () {
                        setState(() {
                          userInput = '';
                          result = '';
                        });
                      }, color: Colors.redAccent), // Clear button color
                      MyButton(title: "+/-", onPress: () {
                        setState(() {});
                      }, color: Colors.orange),
                      MyButton(title: "%", onPress: () {
                        setState(() {
                          userInput = userInput + '%';
                        });
                      }, color: Colors.green),
                      MyButton(color: Colors.pinkAccent, title: "/", onPress: () {
                        setState(() {
                          userInput = userInput + '/';
                        });
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(title: "7", onPress: () {
                        setState(() {
                          userInput = userInput + '7';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "8", onPress: () {
                        setState(() {
                          userInput = userInput + '8';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "9", onPress: () {
                        setState(() {
                          userInput = userInput + '9';
                        });
                      }, color: Colors.blue),
                      MyButton(color: Colors.grey, title: "X", onPress: () {
                        setState(() {
                          userInput = userInput + 'X';
                        });
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(title: "4", onPress: () {
                        setState(() {
                          userInput = userInput + '4';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "5", onPress: () {
                        setState(() {
                          userInput = userInput + '5';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "6", onPress: () {
                        setState(() {
                          userInput = userInput + '6';
                        });
                      }, color: Colors.blue),
                      MyButton(color: Colors.green, title: "-", onPress: () {
                        setState(() {
                          userInput = userInput + '-';
                        });
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(title: "1", onPress: () {
                        setState(() {
                          userInput = userInput + '1';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "2", onPress: () {
                        setState(() {
                          userInput = userInput + '2';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "3", onPress: () {
                        setState(() {
                          userInput = userInput + '3';
                        });
                      }, color: Colors.blue),
                      MyButton(color: Colors.orange, title: "+", onPress: () {
                        setState(() {
                          userInput = userInput + '+';
                        });
                      }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(title: "0", onPress: () {
                        setState(() {
                          userInput = userInput + '0';
                        });
                      }, color: Colors.blue),
                      MyButton(title: "DEL", onPress: () {
                        setState(() {
                          if (userInput.isNotEmpty) {
                            userInput = userInput.substring(0, userInput.length - 1);
                          }
                        });
                      }, color: Colors.red),
                      MyButton(title: ".", onPress: () {
                        setState(() {
                          userInput = userInput + '.';
                        });
                      }, color: Colors.blue),
                      MyButton(color: Colors.red, title: "=", onPress: () {
                        equalPress();
                      }),
                    ],
                  ),
                  // New row for scientific functions
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyButton(title: "sin", color: Colors.purple, onPress: () {
                        setState(() {
                          userInput = "sin(" + userInput + ")";
                        });
                      }),
                      MyButton(title: "cos", color: Colors.green, onPress: () {
                        setState(() {
                          userInput = "cos(" + userInput + ")";
                        });
                      }),
                      MyButton(title: "tan", color: Colors.blue, onPress: () {
                        setState(() {
                          userInput = "tan(" + userInput + ")";
                        });
                      }),
                      MyButton(title: "√", color: Colors.red, onPress: () {
                        setState(() {
                          userInput = "sqrt(" + userInput + ")";
                        });
                      }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void equalPress() {
    try {
      String finalInput = userInput.replaceAll("X", "*");
      Parser p = Parser();
      Expression exp = p.parse(finalInput);
      ContextModel contextModel = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, contextModel);
      result = eval.toString();
    } catch (e) {
      result = "Error";
    }
  }
}

class MyButton extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPress;

  MyButton({super.key, required this.title, this.color = Colors.grey, required this.onPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0), // Increased padding for better touch targets
        child: Container(
          height: 70,
          width: 70,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20), // Rounded corners
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white), // Updated text style
            ),
          ),
        ),
      ),
    );
  }
}

