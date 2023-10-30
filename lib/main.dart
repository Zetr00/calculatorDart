import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  TextEditingController inputController = TextEditingController();
  String output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Калькулятор'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Введите выражение',
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Результат: $output',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCalcButton('+'),
                buildCalcButton('-'),
                buildCalcButton('*'),
                buildCalcButton('/'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCalcButton('7'),
                buildCalcButton('8'),
                buildCalcButton('9'),
                buildConvertButton(2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCalcButton('4'),
                buildCalcButton('5'),
                buildCalcButton('6'),
                buildConvertButton(10),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCalcButton('1'),
                buildCalcButton('2'),
                buildCalcButton('3'),
                buildConvertButton(16),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildCalcButton('0'),
                buildCalcButton('C'),
                buildCalcButton('='),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCalcButton(String label) {
    return ElevatedButton(
      onPressed: () {
        handleButtonPress(label);
      },
      child: Text(label),
    );
  }

  Widget buildConvertButton(int base) {
    return ElevatedButton(
      onPressed: () {
        convertToBase(base);
      },
      child: Text('BASE $base'),
    );
  }

  void handleButtonPress(String value) {
    if (value == '=') {
      calculate();
    } else if (value == 'C') {
      clearInput();
    } else {
      inputController.text += value;
    }
  }

  void clearInput() {
    inputController.clear();
    setState(() {
      output = '';
    });
  }

  void calculate() {
    try {
      final expression = inputController.text;
      Parser p = Parser();
      Expression exp = p.parse(expression);
      ContextModel cm = ContextModel();
      double result = exp.evaluate(EvaluationType.REAL, cm);
      setState(() {
        output = result.toString();
      });
    } catch (e) {
      setState(() {
        output = 'Ошибка';
      });
    }
  }

  void convertToBase(int base) {
    try {
      final value = int.tryParse(inputController.text);
      if (value != null) {
        final convertedValue = value.toRadixString(base).toUpperCase();
        setState(() {
          output = convertedValue;
        });
      } else {
        setState(() {
          output = 'Ошибка';
        });
      }
    } catch (e) {
      setState(() {
        output = 'Ошибка';
      });
    }
  }
}
