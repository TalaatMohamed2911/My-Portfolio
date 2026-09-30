import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:my_portfolio/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
      child: Column(
        spacing: 36.0,
        children: [
          // work projects title
          Text(
            'Work Projects',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),
          // work projects cards
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 18.0,
              children: [
                for (int i = 0; i < workProjectUtils.length; i++)
                  ProjectCardWidget(project: workProjectUtils[i]),
              ],
            ),
          ),
          // Hobby projects title
          Text(
            'Hobby Projects',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),
          // work projects cards
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 900),
            child: Wrap(
              spacing: 12.0,
              runSpacing: 18.0,
              children: [
                for (int i = 0; i < hobbyProjectUtils.length; i++)
                  ProjectCardWidget(project: hobbyProjectUtils[i]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
