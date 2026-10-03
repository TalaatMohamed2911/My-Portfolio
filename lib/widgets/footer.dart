import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      alignment: Alignment.center,
      width: double.maxFinite,
      child: Text(
        '© 2026 Talaat Mohamed. Built With ❤️ Using Flutter & Dart.',
        style: TextStyle(
          color: CustomColor.whiteSecondary,
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
