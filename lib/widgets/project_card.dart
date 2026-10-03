import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:my_portfolio/widgets/project_platform_link.dart';

class ProjectCardWidget extends StatefulWidget {
  const ProjectCardWidget({
    super.key,
    required this.project,
    required this.cardWidth,
  });

  final ProjectUtils project;
  final double cardWidth;

  @override
  State<ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<ProjectCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final imageHeight = (widget.cardWidth * 0.3).clamp(130.0, 210.0);
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, _isHovered ? -7 : 0, 0),
        clipBehavior: Clip.antiAlias,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: CustomColor.bgLight2,
          border: Border.all(
            color: _isHovered
                ? CustomColor.yellowSecondary.withValues(alpha: 0.7)
                : Colors.white.withValues(alpha: 0.04),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: CustomColor.yellowPrimary.withValues(alpha: 0.12),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // project image
            AnimatedScale(
              duration: const Duration(milliseconds: 300),
              scale: _isHovered ? 1.04 : 1,
              child: Image.asset(
                widget.project.image,
                height: imageHeight,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            // title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 10),
              child: Text(
                widget.project.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.whitePrimary,
                ),
              ),
            ),
            // subtitle
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Text(
                widget.project.subtitle,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 15.0,
                  height: 1.45,
                  color: CustomColor.whiteSecondary,
                ),
              ),
            ),
            if (widget.project.technologies.isNotEmpty)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TECHNOLOGIES',
                      style: TextStyle(
                        color: CustomColor.yellowSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Wrap(
                      spacing: 5,
                      runSpacing: 5,
                      children: [
                        for (final technology in widget.project.technologies)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: CustomColor.scaffoldBg.withValues(
                                alpha: 0.55,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: CustomColor.whitePrimary.withValues(
                                  alpha: 0.08,
                                ),
                              ),
                            ),
                            child: Text(
                              technology,
                              style: TextStyle(
                                color: CustomColor.whiteSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            // footer with links
            Container(
              decoration: BoxDecoration(
                color: CustomColor.bgLight2,
                border: Border(
                  top: BorderSide(
                    color: CustomColor.whitePrimary.withValues(alpha: 0.08),
                  ),
                ),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: (widget.cardWidth * 0.04).clamp(12.0, 24.0),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      'Available on:',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: CustomColor.yellowSecondary,
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.project.androidLink case final url?)
                        ProjectPlatformLink(
                          platform: 'Android',
                          asset: 'assets/android_icon.png',
                          url: url,
                          iconWidth: 20,
                        ),
                      if (widget.project.iosLink case final url?)
                        ProjectPlatformLink(
                          platform: 'iOS',
                          asset: 'assets/ios_icon.png',
                          url: url,
                          iconWidth: 22,
                        ),
                      if (widget.project.webLink case final url?)
                        ProjectPlatformLink(
                          platform: 'Web',
                          asset: 'assets/web_icon.png',
                          url: url,
                          iconWidth: 20,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
