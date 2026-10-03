import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class MainDesktop extends StatelessWidget {
  const MainDesktop({
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
    return SizedBox(
      width: double.infinity,
      height: height,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 850),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 18,
              children: [
                Text(
                  'Hello, I\'m',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: CustomColor.yellowSecondary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2.2,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontSize: MediaQuery.sizeOf(context).width < 1250
                          ? 20
                          : 26,
                      height: 1.2,
                      // fontWeight: FontWeight.bold,
                      color: CustomColor.whitePrimary,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Talaat Mohamed\n',
                        style: TextStyle(
                          fontSize: 66,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Junior Flutter Developer\n',
                        style: TextStyle(
                          color: CustomColor.yellowSecondary,
                          fontSize: 32,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                      const TextSpan(
                        text:
                            '\nJunior Flutter Developer with hands-on experience designing, developing, and maintaining cross-platform mobile applications using Flutter and Dart. Passionate about delivering high-quality user experiences and continuously learning modern mobile development technologies.\n',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 12,
                  runSpacing: 10,
                  children: [
                    SizedBox(
                      width: 215,
                      height: 58,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CustomColor.yellowPrimary,
                          foregroundColor: CustomColor.scaffoldBg,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: onCvTap,
                        icon: const Icon(Icons.download_rounded, size: 18),
                        label: const Text('Download CV'),
                      ),
                    ),
                    SizedBox(
                      width: 215,
                      height: 58,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: CustomColor.yellowSecondary,
                          side: BorderSide(
                            color: CustomColor.yellowSecondary.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: onProjectsTap,
                        icon: const Icon(Icons.work_outline, size: 18),
                        label: const Text('View My Work'),
                      ),
                    ),
                    SizedBox(
                      width: 215,
                      height: 58,
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: CustomColor.yellowSecondary,
                          side: BorderSide(
                            color: CustomColor.yellowSecondary.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
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
      ),
    );
  }
}
