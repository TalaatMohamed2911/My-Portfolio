import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 500.0),
      child: Column(
        children: [
          for (int i = 0; i < platformItems.length; i++)
            Container(
              margin: EdgeInsets.only(bottom: 5.0),
              width: double.maxFinite,
              decoration: BoxDecoration(
                color: CustomColor.bgLight2,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                leading: Image.asset(platformItems[i]['img'], width: 26.0),
                title: Text(platformItems[i]['title']),
              ),
            ),
          SizedBox(height: 40.0),
          Wrap(
            spacing: 8.0, // Horizontal spacing between chips
            runSpacing: 8.0, // Vertical spacing between chips
            alignment: WrapAlignment.center,
            children: [
              for (int i = 0; i < skillItems.length; i++)
                Chip(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.0,
                    vertical: 10.0,
                  ),
                  backgroundColor: CustomColor.bgLight2,
                  label: Text(skillItems[i]['title']),
                  avatar: Image.asset(skillItems[i]['img']),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
