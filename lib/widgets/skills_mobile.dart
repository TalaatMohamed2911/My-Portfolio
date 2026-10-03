import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/skill_chips.dart';

class SkillsMobile extends StatelessWidget {
  const SkillsMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkillChips(isCompact: true);
  }
}
