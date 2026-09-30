import 'dart:js_interop_unsafe';
import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'dart:js_interop' as js;

class ProjectCardWidget extends StatelessWidget {
  const ProjectCardWidget({super.key, required this.project});

  final ProjectUtils project;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      height: 290,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: CustomColor.bgLight2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // project image
          Image.asset(
            project.image,
            height: 140,
            width: 260,
            fit: BoxFit.cover,
          ),
          // title
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 15, 12, 11),
            child: Text(
              project.title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: CustomColor.whitePrimary,
              ),
            ),
          ),
          // subtitle
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Text(
              project.subtitle,
              style: TextStyle(
                fontSize: 12.0,
                color: CustomColor.whiteSecondary,
              ),
            ),
          ),
          Spacer(),
          // footer with links
          Container(
            color: CustomColor.bgLight1,
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            child: Row(
              children: [
                Text(
                  'Available on :',
                  style: TextStyle(
                    color: CustomColor.yellowSecondary,
                    fontSize: 10.0,
                  ),
                ),
                Spacer(),
                if (project.androidLink != null)
                  InkWell(
                    onTap: () {
                      js.globalContext.callMethod(
                        'open' as js.JSAny,
                        [project.androidLink] as js.JSAny?,
                      );
                    },
                    child: Image.asset('assets/android_icon.png', width: 18.0),
                  ),
                if (project.iosLink != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: () {
                        js.globalContext.callMethod(
                          'open' as js.JSAny,
                          [project.iosLink] as js.JSAny?,
                        );
                      },
                      child: Image.asset('assets/ios_icon.png', width: 21.0),
                    ),
                  ),
                if (project.webLink != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: InkWell(
                      onTap: () {
                        js.globalContext.callMethod(
                          'open' as js.JSAny,
                          [project.webLink] as js.JSAny?,
                        );
                      },
                      child: Image.asset('assets/web_icon.png', width: 18.0),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
