import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          Flexible(flex: 1, child: Container()),
          Container(
            width: 250,
            height: 250,
            color: Colors.pink,
          ),
          const Text(
            'Lorem Ipsum Dolor Sit amer',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 30),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Neque porro quisquam est qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit.',
            style: TextStyle(fontWeight: FontWeight.w300, fontSize: 18),
          ),
          Flexible(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
