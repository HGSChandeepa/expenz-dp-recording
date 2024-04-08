import 'package:flutter/material.dart';
import 'package:expenz/constants/colors.dart';

class FrontPage extends StatelessWidget {
  const FrontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          "assets/images/logo.png",
          width: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          height: 20,
        ),
        const Center(
          child: Text(
            "Expenz",
            style: TextStyle(
              fontSize: 40,
              color: kMainColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
