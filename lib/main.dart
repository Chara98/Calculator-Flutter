import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calc());
}

class Calc extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      title: 'calc',
      home: SCalc(),
    );

  }
}

class SCalc extends StatefulWidget {
  @override
  _SCalcState createState() => _SCalcState();
}

class _SCalcState extends State<SCalc> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFontsize = 38.0;
  double resultFontsize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if(buttonText == "C") {
        equation = "0";
        result = "0";
        double equationFontsize = 38.0;
        double resultFontsize = 48.0;
      }else if(buttonText == "⌫"){
        double equationFontsize = 48.0;
        double resultFontsize = 38.0;
        equation = equation.substring(0, equation.length - 1);
        if(equation == "")  {
          equation = "0";
        }
      }else if(buttonText == "="){
        double equationFontsize = 38.0;
        double resultFontsize = 48.0;
        expression = equation;
        expression = equation.replaceAll('*', '*');
        expression = equation.replaceAll('÷', '/');
        try{
          Parser p = new Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        }catch(e){
          result = 'Error';
        }
      }else {
        double equationFontsize = 48.0;
        double resultFontsize = 38.0;
        if(equation == "0") {
          equation = buttonText;
        }else {
          equation = equation + buttonText;
        }
      }
    });
  }
  @override

  Widget builButton(String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        onPressed: () => buttonPressed(buttonText),
        child: Text(buttonText, style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.normal,color: Colors.white,),),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chara98 - Calculator'),),
      body:  Column(children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(equation, style: TextStyle(fontSize: equationFontsize),),
        ),

        Container(
          alignment: Alignment.centerRight,
          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
          child: Text(result, style: TextStyle(fontSize: resultFontsize),),
        ),

        Expanded(
            child: Divider(),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .75,
              child: Table(
                children: [
                  TableRow(
                    children: <Widget>[
                      builButton("C",1, Colors.redAccent),
                      builButton("⌫", 1, Colors.blue),
                      builButton("÷", 1, Colors.blue)
                    ],
                  ),

                  TableRow(
                    children: <Widget>[
                      builButton("7",1, Colors.black54),
                      builButton("8", 1, Colors.black54),
                      builButton("9", 1, Colors.black54)
                    ],
                  ),

                  TableRow(
                    children: <Widget>[
                      builButton("4",1, Colors.black54),
                      builButton("5", 1, Colors.black54),
                      builButton("6", 1, Colors.black54)
                    ],
                  ),

                  TableRow(
                    children: <Widget>[
                      builButton("1",1, Colors.black54),
                      builButton("2", 1, Colors.black54),
                      builButton("3", 1, Colors.black54)
                    ],
                  ),

                  TableRow(
                    children: <Widget>[
                      builButton(".",1, Colors.black54),
                      builButton("0", 1, Colors.black54),
                      builButton("00", 1, Colors.black54)
                    ],
                  ),
                ]
              ),
            ),

            Container(
              width: MediaQuery.of(context).size.width * 0.25,
              child: Table(
                children: [
                  TableRow(
                    children: [
                      builButton("*", 1, Colors.blue)
                    ],
                  ),

                  TableRow(
                    children: [
                      builButton("-", 1, Colors.blue)
                    ],
                  ),

                  TableRow(
                    children: [
                      builButton("+", 1, Colors.blue)
                    ],
                  ),

                  TableRow(
                    children: [
                      builButton("=", 2, Colors.redAccent)
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ],)
    );
  }
}
