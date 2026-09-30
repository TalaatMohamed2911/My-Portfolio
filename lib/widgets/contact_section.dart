import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/constants/sns_links.dart';
import 'package:my_portfolio/widgets/custom_text_field.dart';
import 'dart:js' as js;

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
      color: CustomColor.bgLight1,
      child: Column(
        spacing: 16.0,
        children: [
          // title
          Text(
            'Get in touch',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
              color: CustomColor.whitePrimary,
            ),
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700, maxHeight: 100),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= kMinDesktopWidth) {
                  return buildDesktopNameEmailFields();
                }
                return buildMobileNameEmailFields();
              },
            ),
          ),
          // Message
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: CustomTextField(hintText: 'Your Message', maxLines: 12),
          ),
          // send Button
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 700),
            child: SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Get in touch'),
              ),
            ),
          ),
          SizedBox(),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400.0),
            child: Divider(),
          ),
          SizedBox(),
          // SNS icon button links
          Wrap(
            spacing: 46.0,
            runSpacing: 5.0,
            alignment: WrapAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  js.context.callMethod('open', [SnsLinks.github]);
                },
                child: Image.asset('assets/github.png', width: 30.0),
              ),
              InkWell(
                onTap: () {
                  js.context.callMethod('open', [SnsLinks.linkedIn]);
                },
                child: Image.asset('assets/linkedin.png', width: 28.0),
              ),
              InkWell(
                onTap: () {
                  // js.context.callMethod('open', [SnsLinks.telegram]);
                },
                child: Image.asset('assets/telegram.png', width: 32.0),
              ),
              InkWell(
                onTap: () {
                  js.context.callMethod('open', [SnsLinks.facebook]);
                },
                child: Image.asset('assets/facebook.png', width: 28.0),
              ),
              InkWell(
                onTap: () {
                  js.context.callMethod('open', [SnsLinks.instagram]);
                },
                child: Image.asset('assets/instagram.png', width: 28.0),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildDesktopNameEmailFields() {
    return Row(
      spacing: 12.0,
      children: [
        // Name
        Flexible(child: CustomTextField(hintText: 'Your Name')),
        // Email
        Flexible(child: CustomTextField(hintText: 'Your Email')),
      ],
    );
  }

  Column buildMobileNameEmailFields() {
    return Column(
      spacing: 12.0,
      children: [
        // Name
        Flexible(child: CustomTextField(hintText: 'Your Name')),
        // Email
        Flexible(child: CustomTextField(hintText: 'Your Email')),
      ],
    );
  }
}
