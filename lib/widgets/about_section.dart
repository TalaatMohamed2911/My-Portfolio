import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/widgets/accent_section_title.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final portrait = Container(
          width: isWide ? 290 : (constraints.maxWidth - 50).clamp(0, 320),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: CustomColor.bgLight2,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: CustomColor.yellowSecondary.withValues(alpha: 0.2),
            ),
            boxShadow: [
              BoxShadow(
                color: CustomColor.yellowPrimary.withValues(alpha: 0.08),
                blurRadius: 30,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Image.asset('assets/profile.jpg', fit: BoxFit.contain),
          ),
        );
        final biography = Column(
          crossAxisAlignment: isWide
              ? CrossAxisAlignment.start
              : CrossAxisAlignment.center,
          children: [
            AccentSectionTitle(
              key: const ValueKey('about-section-title'),
              beforeAccent: 'About ',
              accent: 'Me',
              textAlign: isWide ? TextAlign.start : TextAlign.center,
            ),
            const SizedBox(height: 18),
            Text(
              'Results-driven Junior Flutter Developer with hands-on experience designing, '
              'developing, and maintaining cross-platform mobile applications using Flutter and Dart. '
              'Proficient in building responsive and scalable UI, '
              'integrating RESTful APIs, Firebase, and third-party services, and implementing real-time data functionality. '
              'Familiar with state management, asynchronous programming, JSON parsing, debugging, Git/GitHub, and clean code principles. '
              'Passionate about delivering high-quality user experiences and continuously learning modern mobile development technologies.',
              textAlign: isWide ? TextAlign.start : TextAlign.center,
              style: TextStyle(
                fontSize: 19,
                height: 1.6,
                color: CustomColor.whiteSecondary,
              ),
            ),
            const SizedBox(height: 14),
          ],
        );

        return Container(
          width: double.infinity,
          color: CustomColor.bgLight1,
          padding: const EdgeInsets.fromLTRB(30, 48, 30, 72),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1040),
              child: isWide
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        portrait,
                        const SizedBox(width: 40),
                        Expanded(child: biography),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        portrait,
                        const SizedBox(height: 28),
                        biography,
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
