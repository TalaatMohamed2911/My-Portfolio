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
        'Made by Talaat Mohamed with Flutter 3.32.4 ❤️',
        style: TextStyle(
          color: CustomColor.whiteSecondary,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
