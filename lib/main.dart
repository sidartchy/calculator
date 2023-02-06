import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:saral_hisab/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyCalculator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyCalculator extends StatefulWidget {
  const MyCalculator({super.key});

  @override
  State<MyCalculator> createState() => _MyCalculatorState();
}

class _MyCalculatorState extends State<MyCalculator> {
  var input = '';
  var output = '';
  var opearation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClicked(value) {
    // for AC
    if (value == "AC") {
      input = "";
      output = "";
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        output = finalValue.toString();
        if (output.endsWith(".0")) {
          output = output.substring(0, output.length - 2);
        }
        input = output;
        hideInput = true;
        outputSize = 52.0;
      }
    } else {
      input += value;
      hideInput = false;
      outputSize = 34.0;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // display area
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    hideInput ? '' : input,
                    style: const TextStyle(fontSize: 48.0, color: Colors.white),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    output,
                    style: TextStyle(
                        fontSize: outputSize,
                        color: Colors.white.withOpacity(0.7)),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ),

          //button area
          Row(
            children: [
              button(
                  text: "AC",
                  tColor: Colors.orange,
                  buttonBgColor: operatorColor),
              button(text: "<", tColor: Colors.orange),
              button(text: "", buttonBgColor: Colors.transparent),
              button(
                  text: "/",
                  tColor: Colors.orange,
                  buttonBgColor: operatorColor)
            ],
          ),
          Row(
            children: [
              button(text: "7"),
              button(text: "8"),
              button(text: "9"),
              button(
                  text: "*", tColor: Colors.orange, buttonBgColor: buttonColor)
            ],
          ),
          Row(
            children: [
              button(text: "4"),
              button(text: "5"),
              button(text: "6"),
              button(
                  text: "+", tColor: Colors.orange, buttonBgColor: buttonColor)
            ],
          ),
          Row(
            children: [
              button(text: "1"),
              button(text: "2"),
              button(text: "3"),
              button(
                  text: "-", tColor: Colors.orange, buttonBgColor: buttonColor)
            ],
          ),
          Row(
            children: [
              button(text: "%"),
              button(text: "0"),
              button(text: "."),
              button(text: "=", buttonBgColor: Colors.red)
            ],
          )
        ],
      ),
    );
  }

  Widget button({text, tColor = Colors.white, buttonBgColor = buttonColor}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(22),
              backgroundColor: buttonBgColor),
          onPressed: () => onButtonClicked(text),
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: tColor),
          ),
        ),
      ),
    );
  }
}
