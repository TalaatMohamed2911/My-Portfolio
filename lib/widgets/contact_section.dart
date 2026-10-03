import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/sns_links.dart';
import 'package:my_portfolio/utils/external_url.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: CustomColor.bgLight1,
      padding: const EdgeInsets.fromLTRB(28, 60, 28, 76),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 820),
          child: Column(
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: CustomColor.whitePrimary,
                  ),
                  children: [
                    const TextSpan(text: 'Let’s build something '),
                    TextSpan(
                      text: 'great.',
                      style: TextStyle(color: CustomColor.yellowSecondary),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: Text(
                  'I’m always open to discussing new projects, creative ideas, '
                  'or opportunities to work together.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    height: 1.6,
                    color: CustomColor.whiteSecondary,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  final cards = [
                    _ContactMethodCard(
                      title: 'Email me',
                      subtitle: SnsLinks.contactEmail,
                      icon: Icons.mail_rounded,
                      onTap: () =>
                          openExternalUrl('mailto:${SnsLinks.contactEmail}'),
                    ),
                    _ContactMethodCard(
                      title: 'WhatsApp',
                      subtitle: 'Let’s chat directly',
                      icon: Icons.chat_rounded,
                      onTap: () => openExternalUrl(SnsLinks.whatsapp),
                    ),
                  ];

                  if (constraints.maxWidth < 580) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(width: constraints.maxWidth, child: cards[0]),
                        const SizedBox(height: 14),
                        SizedBox(width: constraints.maxWidth, child: cards[1]),
                      ],
                    );
                  }
                  return Row(
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 18),
                      Expanded(child: cards[1]),
                    ],
                  );
                },
              ),
              const SizedBox(height: 26),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 14,
                runSpacing: 12,
                children: [
                  _SocialLink(
                    label: 'LinkedIn',
                    asset: 'assets/linkedin.png',
                    url: SnsLinks.linkedIn,
                  ),
                  _SocialLink(
                    label: 'GitHub',
                    asset: 'assets/github.png',
                    url: SnsLinks.github,
                  ),
                  _SocialLink(
                    label: 'Instagram',
                    asset: 'assets/instagram.png',
                    url: SnsLinks.instagram,
                  ),
                  _SocialLink(
                    label: 'Facebook',
                    asset: 'assets/facebook.png',
                    url: SnsLinks.facebook,
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

class _ContactMethodCard extends StatelessWidget {
  const _ContactMethodCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 178),
          child: Ink(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomColor.bgLight2,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: CustomColor.whitePrimary.withValues(alpha: 0.08),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    color: CustomColor.yellowPrimary.withValues(alpha: 0.14),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: CustomColor.yellowSecondary,
                    size: 26,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    color: CustomColor.whitePrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    color: CustomColor.whiteSecondary,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialLink extends StatelessWidget {
  const _SocialLink({
    required this.label,
    required this.asset,
    required this.url,
  });

  final String label;
  final String asset;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: () => openExternalUrl(url),
          customBorder: const CircleBorder(),
          child: Ink(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: CustomColor.bgLight2,
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomColor.whitePrimary.withValues(alpha: 0.1),
              ),
            ),
            child: Center(child: Image.asset(asset, width: 23, height: 23)),
          ),
        ),
      ),
    );
  }
}
