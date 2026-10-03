import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';

class SiteLogo extends StatelessWidget {
  const SiteLogo({super.key, this.onTap});
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          children: [
            TextSpan(
              text: 'Talaat',
              style: TextStyle(color: CustomColor.whitePrimary),
            ),
            TextSpan(
              text: '.dev',
              style: TextStyle(color: CustomColor.yellowPrimary),
            ),
          ],
        ),
      ),
    );
  }
}
