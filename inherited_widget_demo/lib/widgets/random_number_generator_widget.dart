import 'dart:math';

import 'package:flutter/material.dart';

class RandomNumberGeneratorWidget extends StatefulWidget {
  const RandomNumberGeneratorWidget({super.key});

  @override
  State<RandomNumberGeneratorWidget> createState() =>
      _RandomNumberGeneratorWidgetState();
}

class _RandomNumberGeneratorWidgetState
    extends State<RandomNumberGeneratorWidget> {
  int randomNumber = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    debugPrint(
      "Changed random number generator  dependency",
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          randomNumber.toString(),
          style: TextStyle(
            color: const Color.fromARGB(211, 229, 13, 74),
          ),
        ),
        OutlinedButton(
          onPressed: () => setState(
            () => randomNumber = Random().nextInt(100),
          ),
          child: Text(
            "Generate",
            style: TextStyle(color: Colors.deepPurple),
          ),
        ),
      ],
    );
  }
}
