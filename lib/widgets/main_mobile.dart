import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainMobile extends StatelessWidget {
  const MainMobile({
    super.key,
    required this.height,
    required this.onProjectsTap,
    required this.onContactTap,
    required this.onCvTap,
  });

  final double height;
  final VoidCallback onProjectsTap;
  final VoidCallback onContactTap;
  final VoidCallback onCvTap;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final isCompactHeight = screenSize.height < 620;
    final isNarrow = screenSize.width < 360;
    final isVeryCompact = isNarrow && isCompactHeight;
    final buttonWidth = ((screenSize.width - 48 - 10) / 2)
        .clamp(130.0, 174.0)
        .toDouble();
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: isCompactHeight ? 10 : 16,
            children: [
              Text(
                'Hello, I\'m',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColor.yellowSecondary,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: isNarrow ? 30 : 36,
                    height: 1.15,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whitePrimary,
                  ),
                  children: [
                    const TextSpan(
                      text: 'Talaat Mohamed\n',
                      style: TextStyle(fontSize: 36),
                    ),
                    TextSpan(
                      text: 'Junior Flutter Developer\n',
                      style: TextStyle(
                        color: CustomColor.yellowSecondary,
                        fontSize: isNarrow ? 19 : 22,
                      ),
                    ),
                    TextSpan(
                      text: isVeryCompact
                          ? 'Building responsive mobile and web apps with Flutter and Dart.'
                          : 'Junior Flutter Developer with hands-on experience designing, developing, and maintaining cross-platform mobile applications using Flutter and Dart. Passionate about delivering high-quality user experiences and continuously learning modern mobile development technologies.',
                      style: TextStyle(
                        fontSize: isNarrow ? 13 : 14,
                        height: 1.3,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: [
                  SizedBox(
                    width: buttonWidth,
                    height: isCompactHeight ? 46 : 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: CustomColor.yellowPrimary,
                        foregroundColor: CustomColor.scaffoldBg,
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onPressed: onCvTap,
                      icon: const Icon(Icons.download_rounded, size: 18),
                      label: const Text('Download CV'),
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    height: isCompactHeight ? 46 : 50,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: CustomColor.yellowSecondary,
                        side: BorderSide(
                          color: CustomColor.yellowSecondary.withValues(
                            alpha: 0.7,
                          ),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onPressed: onProjectsTap,
                      icon: const Icon(Icons.work_outline, size: 18),
                      label: const Text('View My Work'),
                    ),
                  ),
                  SizedBox(
                    width: buttonWidth,
                    height: isCompactHeight ? 46 : 50,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: CustomColor.yellowSecondary,
                        side: BorderSide(
                          color: CustomColor.yellowSecondary.withValues(
                            alpha: 0.7,
                          ),
                        ),
                        textStyle: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onPressed: onContactTap,
                      icon: const Icon(Icons.mail_outline_rounded, size: 18),
                      label: const Text('Contact Me'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
