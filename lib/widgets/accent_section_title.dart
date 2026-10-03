import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class AccentSectionTitle extends StatelessWidget {
  const AccentSectionTitle({
    super.key,
    required this.beforeAccent,
    required this.accent,
    this.textAlign = TextAlign.center,
    this.fontSize = 32,
  });

  final String beforeAccent;
  final String accent;
  final TextAlign textAlign;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: CustomColor.whitePrimary,
        ),
        children: [
          TextSpan(text: beforeAccent),
          TextSpan(
            text: accent,
            style: TextStyle(color: CustomColor.yellowPrimary),
          ),
        ],
      ),
      textAlign: textAlign,
    );
  }
}
