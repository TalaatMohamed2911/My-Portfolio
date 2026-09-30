import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;
    return Container(
      height: screenHeight,
      constraints: BoxConstraints(minHeight: 560.0),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: Column(
        spacing: 8.0,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // avatar image
          ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [
                  CustomColor.scaffoldBg.withValues(alpha: 0.6),
                  CustomColor.scaffoldBg.withValues(alpha: 0.6),
                ],
              ).createShader(bounds);
            },
            blendMode: BlendMode.srcATop,
            child: Image.asset(
              'assets/my_flutter_avatar.png',
              width: screenWidth,
            ),
          ),

          // Intro Text
          Text(
            'Hi, \nI\'m Talaat Mohamed \nA Flutter Developer',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),
          // Button
          SizedBox(
            width: 200.0,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Get in touch'),
            ),
          ),
        ],
      ),
    );
  }
}
