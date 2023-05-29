import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InitialisingText extends StatelessWidget {
  const InitialisingText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedTextKit(
          animatedTexts: [
            TyperAnimatedText('Initialising...',
                textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade300)),
          ],
          onTap: () {},
        ),
      ],
    );
  }
}

class transactionNotFoundText extends StatelessWidget {
  const transactionNotFoundText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, top: 8),
      child: AnimatedTextKit(animatedTexts: [
        TyperAnimatedText('No Transactions Found  !',
            textStyle: TextStyle(
              color: Colors.blue.shade900,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ))
      ]),
    );
  }
}

class categoryNotFoundText extends StatelessWidget {
  const categoryNotFoundText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 20, top: 0),
        child: Column(
          children: [
            Lottie.asset('animations/category_not_found.json'),
            AnimatedTextKit(animatedTexts: [
              TyperAnimatedText('Add Category',
                  textStyle: TextStyle(
                    color: Color.fromARGB(255, 240, 94, 94),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ))
            ]),
          ],
        ));
  }
}