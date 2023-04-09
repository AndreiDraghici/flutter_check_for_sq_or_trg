import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Check(),
    );
  }
}

class Check extends StatefulWidget {
  const Check({Key? key}) : super(key: key);

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  TextEditingController _input_numer = TextEditingController();
  int _is_squared = 0;
  int _is_triangle = 0;
  String ans = "";
  String input = "";

  void reset() {
    _is_squared = 0;
    _is_triangle = 0;
    ans = "";
  }

  showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("Ok."),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Text(
        input.toString(),
      ),
      content: Text(
        ans,
      ),
      actions: [
        okButton,
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  void verify(dynamic nr) {
    try {
      nr = int.parse(nr);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
    int sq = sqrt(nr).round();
    int trg = pow(nr, 1 / 3).round();

    if (nr == sq * sq) {
      _is_squared = 1;
    }
    if (nr == trg * trg * trg) {
      _is_triangle = 1;
    }
    if (_is_squared == 1 && _is_triangle == 1) {
      ans = "Number is Squared and Triangle";
    } else if (_is_triangle == 1) {
      ans = "Number is Triangle";
    } else if (_is_squared == 1) {
      ans = "Number is squared";
    } else {
      ans = "Number is not squared nor triangle";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number Shapes"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              "Please input a number to see if it is square or triangular.",
              style: TextStyle(fontSize: 25),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: "Number:"),
            controller: _input_numer,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          input = _input_numer.text;
          verify(input);
          showAlertDialog(context);
          reset();
        },
      ),
    );
  }
}
