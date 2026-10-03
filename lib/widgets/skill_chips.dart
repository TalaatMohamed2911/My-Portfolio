import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/skill_items.dart';

class SkillChips extends StatelessWidget {
  const SkillChips({super.key, required this.isCompact});

  final bool isCompact;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: isCompact ? 500 : 1000),
        child: Wrap(
          spacing: 8,
          runSpacing: isCompact ? 8 : 10,
          alignment: WrapAlignment.center,
          children: [
            for (final skill in skillItems)
              Chip(
                shape: isCompact
                    ? RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    : null,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                backgroundColor: CustomColor.bgLight2,
                label: Text(
                  skill['title'],
                  style: TextStyle(fontSize: isCompact ? 16 : 17),
                ),
                avatar: Image.asset(skill['img']),
              ),
          ],
        ),
      ),
    );
  }
}
