import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class myMoneyHeading extends StatelessWidget {
  const myMoneyHeading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      'My Money',
      style: GoogleFonts.lobster(
          fontSize: 40,
          fontWeight: FontWeight.bold,
          color: Colors.blue.shade300),
    ));
  }
}
