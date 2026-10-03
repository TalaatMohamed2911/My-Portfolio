import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:my_portfolio/widgets/accent_section_title.dart';
import 'package:my_portfolio/widgets/project_card.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(32, 36, 32, 80),
      child: Column(
        spacing: 48,
        children: [
          AccentSectionTitle(
            key: const ValueKey('projects-section-title'),
            beforeAccent: 'Work ',
            accent: 'Projects',
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isTwoColumn =
                    MediaQuery.sizeOf(context).width >= kMinDesktopWidth;
                final cardWidth = isTwoColumn
                    ? (constraints.maxWidth - 24) / 2
                    : constraints.maxWidth;

                if (!isTwoColumn) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 28,
                    children: [
                      for (final project in workProjectUtils)
                        ProjectCardWidget(
                          project: project,
                          cardWidth: cardWidth,
                        ),
                    ],
                  );
                }

                return Column(
                  spacing: 28,
                  children: [
                    for (
                      var index = 0;
                      index < workProjectUtils.length;
                      index += 2
                    )
                      IntrinsicHeight(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: ProjectCardWidget(
                                project: workProjectUtils[index],
                                cardWidth: cardWidth,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: index + 1 < workProjectUtils.length
                                  ? ProjectCardWidget(
                                      project: workProjectUtils[index + 1],
                                      cardWidth: cardWidth,
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
