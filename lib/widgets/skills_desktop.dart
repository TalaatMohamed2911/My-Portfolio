import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class SkillsDesktop extends StatelessWidget {
  const SkillsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Platforms
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 450.0),
          child: Wrap(
            spacing: 5.0, // Horizontal spacing between items
            runSpacing: 5.0, // Vertical spacing between items
            children: [
              for (int i = 0; i < platformItems.length; i++)
                Container(
                  width: 190.0,
                  decoration: BoxDecoration(
                    color: CustomColor.bgLight2,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 15.0,
                      vertical: 8.0,
                    ),
                    leading: Image.asset(platformItems[i]['img'], width: 22.0),
                    title: Text(platformItems[i]['title']),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(width: 40.0),
        // Skills
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Wrap(
              spacing: 5.0, // Horizontal spacing between chips
              runSpacing: 3.0, // Vertical spacing between chips
              children: [
                for (int i = 0; i < skillItems.length; i++)
                  Chip(
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
          ),
        ),
      ],
    );
  }
}
