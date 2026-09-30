import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';
import 'package:my_portfolio/styles/style.dart';
import 'package:my_portfolio/widgets/site_logo.dart';

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({super.key, required this.onNavItemTap});
  final Function(int) onNavItemTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: kHeaderDecoration,
      height: 60,
      width: double.maxFinite,
      child: Row(
        children: [
          SiteLogo(onTap: () {}),
          Spacer(),
          for (int i = 0; i < navTitles.length; i++)
            TextButton(
              onPressed: () {
                onNavItemTap(i);
              },
              child: Text(
                navTitles[i],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: CustomColor.whitePrimary,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
