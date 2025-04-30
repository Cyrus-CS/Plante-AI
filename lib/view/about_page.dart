import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("À propos"),
        backgroundColor: Color(0xFF234520),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          "PlantIA est une application mobile qui permet de détecter les maladies des plantes à partir d’une photo prise avec la caméra ou importée depuis la galerie. Elle reconnaît les plantes comme le pommier, le manguier ou la tomate et fournit un diagnostic précis ainsi que des conseils d’entretien adaptés.",
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
