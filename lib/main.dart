import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Check(),
    );
  }
}

class Check extends StatefulWidget {
  const Check({super.key});

  @override
  State<Check> createState() => _CheckState();
}

class _CheckState extends State<Check> {
  final TextEditingController _inputNumber = TextEditingController();
  int _isSquared = 0;
  int _isTriangle = 0;
  String ans = '';
  String input = '';

  void reset() {
    _isSquared = 0;
    _isTriangle = 0;
    ans = '';
  }

  void showAlertDialog(BuildContext context) {
    final TextButton okButton = TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: const Text('Ok.'),
    );

    final AlertDialog alertDialog = AlertDialog(
      title: Text(
        input,
      ),
      content: Text(
        ans,
      ),
      actions: <Widget>[
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }

  void verify(String number) {
    int nr;
    try {
      nr = int.parse(number);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return;
    }
    final int sq = sqrt(nr).round();
    final int trg = pow(nr, 1 / 3).round();

    if (nr == sq * sq) {
      _isSquared = 1;
    }
    if (nr == trg * trg * trg) {
      _isTriangle = 1;
    }
    if (_isSquared == 1 && _isTriangle == 1) {
      ans = 'Number is Squared and Triangle';
    } else if (_isTriangle == 1) {
      ans = 'Number is Triangle';
    } else if (_isSquared == 1) {
      ans = 'Number is squared';
    } else {
      ans = 'Number is not squared nor triangle';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Shapes'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 25),
            child: Text(
              'Please input a number to see if it is square or triangular.',
              style: TextStyle(fontSize: 25),
            ),
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Number:'),
            controller: _inputNumber,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          input = _inputNumber.text;
          verify(input);
          showAlertDialog(context);
          reset();
        },
      ),
    );
  }
}
