import 'package:flutter/material.dart';
import 'package:my_portfolio/utils/external_url.dart';

class ProjectPlatformLink extends StatelessWidget {
  const ProjectPlatformLink({
    super.key,
    required this.platform,
    required this.asset,
    required this.url,
    required this.iconWidth,
  });

  final String platform;
  final String asset;
  final String url;
  final double iconWidth;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: platform,
      onPressed: () => openExternalUrl(url),
      icon: Image.asset(asset, width: iconWidth),
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
    );
  }
}
