import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainDesktop extends StatelessWidget {
  const MainDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      height: screenSize.height / 1.2,
      constraints: BoxConstraints(minHeight: 350.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 15.0,
            children: [
              // Intro Text
              Text(
                'Hi, \nI\'m Talaat Mohamed \nA Flutter Developer',
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                  color: CustomColor.whitePrimary,
                ),
              ),
              // Button
              SizedBox(
                width: 250.0,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Get in touch'),
                ),
              ),
            ],
          ),
          Image.asset('assets/my_flutter_avatar.png', width: screenWidth / 2.9),
        ],
      ),
    );
  }
}
