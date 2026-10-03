import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/skill_chips.dart';

class SkillsDesktop extends StatelessWidget {
  const SkillsDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const SkillChips(isCompact: false);
  }
}
