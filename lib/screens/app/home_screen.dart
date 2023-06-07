import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Welcome Home",
          style: GoogleFonts.poppins(
              fontSize: 30, fontWeight: FontWeight.w500, color: Colors.blue),
        ),
      ),
    );
  }
}
