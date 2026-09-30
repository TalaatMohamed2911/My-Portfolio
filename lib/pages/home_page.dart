import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/constants/sns_links.dart';
import 'package:my_portfolio/widgets/contact_section.dart';
import 'package:my_portfolio/widgets/drawer_mobile.dart';
import 'package:my_portfolio/widgets/footer.dart';
import 'package:my_portfolio/widgets/header_desktop.dart';
import 'package:my_portfolio/widgets/header_mobile.dart';
import 'package:my_portfolio/widgets/main_desktop.dart';
import 'package:my_portfolio/widgets/main_mobile.dart';
import 'package:my_portfolio/widgets/projects_section.dart';
import 'package:my_portfolio/widgets/skills_desktop.dart';
import 'package:my_portfolio/widgets/skills_mobile.dart';
import 'dart:js' as js;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  final List<GlobalKey> navBarKeys = List.generate(4, (index) => GlobalKey());
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, boxConstraints) {
        return Scaffold(
          key: scaffoldKey,
          endDrawer: boxConstraints.maxWidth >= kMinDesktopWidth
              ? null
              : DrawerMobile(
                  onNavMenuItemTap: (selectedIndex) {
                    // Call func
                    scaffoldKey.currentState?.closeEndDrawer();
                    scrollToSection(selectedIndex);
                  },
                ),
          backgroundColor: CustomColor.scaffoldBg,
          body: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(key: navBarKeys.first),
                // Header Section
                if (boxConstraints.maxWidth >= kMinDesktopWidth)
                  HeaderDesktop(
                    onNavItemTap: (selectedIndex) {
                      // Call func
                      scrollToSection(selectedIndex);
                    },
                  )
                else
                  HeaderMobile(
                    onLogoTap: () {},
                    onMenuTap: () {
                      scaffoldKey.currentState?.openEndDrawer();
                    },
                  ),

                // Main Section
                if (boxConstraints.maxWidth >= kMinDesktopWidth)
                  MainDesktop()
                else
                  MainMobile(),

                // Skills Section
                Container(
                  key: navBarKeys[1],
                  padding: EdgeInsets.fromLTRB(25, 20, 25, 60),
                  width: screenWidth,
                  color: CustomColor.bgLight1,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    spacing: 40.0,
                    children: [
                      // Title
                      Text(
                        'What i can do',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: CustomColor.whitePrimary,
                        ),
                      ),

                      // Platform and skills
                      if (boxConstraints.maxWidth >= kMedDesktopWidth)
                        SkillsDesktop()
                      else
                        SkillsMobile(),
                    ],
                  ),
                ),

                // Projects Section
                ProjectsSection(key: navBarKeys[2]),

                // Contact Section
                ContactSection(key: navBarKeys[3]),

                // Footer Section
                Footer(),
              ],
            ),
          ),
        );
      },
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      js.context.callMethod('open', [SnsLinks.kCV]);
      return;
    }

    final key = navBarKeys[navIndex];
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(seconds: 1),
      curve: Curves.bounceOut,
    );
  }
}
