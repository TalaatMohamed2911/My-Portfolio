import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/constants/sns_links.dart';
import 'package:my_portfolio/widgets/contact_section.dart';
import 'package:my_portfolio/widgets/about_section.dart';
import 'package:my_portfolio/widgets/drawer_mobile.dart';
import 'package:my_portfolio/widgets/footer.dart';
import 'package:my_portfolio/widgets/header_desktop.dart';
import 'package:my_portfolio/widgets/header_mobile.dart';
import 'package:my_portfolio/widgets/main_desktop.dart';
import 'package:my_portfolio/widgets/main_mobile.dart';
import 'package:my_portfolio/widgets/projects_section.dart';
import 'package:my_portfolio/widgets/skills_desktop.dart';
import 'package:my_portfolio/widgets/skills_mobile.dart';
import 'package:my_portfolio/widgets/scroll_reveal.dart';
import 'package:my_portfolio/utils/external_url.dart';
import 'package:my_portfolio/widgets/accent_section_title.dart';

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
        final isDesktop = boxConstraints.maxWidth >= kMinDesktopWidth;
        final pinnedHeaderHeight =
            (isDesktop ? 80.0 : 72.0) + MediaQuery.paddingOf(context).top;
        final heroHeight =
            (MediaQuery.sizeOf(context).height - pinnedHeaderHeight)
                .clamp(0.0, double.infinity)
                .toDouble();
        return SelectionArea(
          child: Scaffold(
            key: scaffoldKey,
            endDrawer: boxConstraints.maxWidth >= kMinDesktopWidth
                ? null
                : DrawerMobile(
                    onNavMenuItemTap: (selectedIndex) {
                      scaffoldKey.currentState?.closeEndDrawer();
                      scrollToSection(selectedIndex);
                    },
                  ),
            backgroundColor: CustomColor.scaffoldBg,
            body: Stack(
              children: [
                SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      SizedBox(height: pinnedHeaderHeight),
                      ScrollReveal(
                        scrollController: scrollController,
                        child: isDesktop
                            ? MainDesktop(
                                height: heroHeight,
                                onProjectsTap: () => scrollToSection(2),
                                onContactTap: () => scrollToSection(3),
                                onCvTap: () => downloadExternalFile(
                                  SnsLinks.kCVDownload,
                                  'Talaat-Mohamed-CV.pdf',
                                ),
                              )
                            : MainMobile(
                                height: heroHeight,
                                onProjectsTap: () => scrollToSection(2),
                                onContactTap: () => scrollToSection(3),
                                onCvTap: () => downloadExternalFile(
                                  SnsLinks.kCVDownload,
                                  'Talaat-Mohamed-CV.pdf',
                                ),
                              ),
                      ),
                      ScrollReveal(
                        key: navBarKeys[0],
                        scrollController: scrollController,
                        child: const AboutSection(),
                      ),
                      ScrollReveal(
                        key: navBarKeys[1],
                        scrollController: scrollController,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(30, 32, 30, 72),
                          width: screenWidth,
                          color: CustomColor.bgLight1,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AccentSectionTitle(
                                key: const ValueKey('skills-section-title'),
                                beforeAccent: 'Technical ',
                                accent: 'Skills',
                              ),
                              Text(
                                'A showcase of the technologies and tools I use to bring digital products to life.',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: CustomColor.whiteSecondary,
                                ),
                              ),
                              SizedBox(height: 40.0),
                              if (boxConstraints.maxWidth >= kMedDesktopWidth)
                                SkillsDesktop()
                              else
                                SkillsMobile(),
                            ],
                          ),
                        ),
                      ),
                      ScrollReveal(
                        key: navBarKeys[2],
                        scrollController: scrollController,
                        child: ProjectsSection(),
                      ),
                      ScrollReveal(
                        key: navBarKeys[3],
                        scrollController: scrollController,
                        child: ContactSection(),
                      ),
                      Footer(),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: SafeArea(
                    bottom: false,
                    child: isDesktop
                        ? HeaderDesktop(
                            onNavItemTap: scrollToSection,
                            onLogoTap: scrollToTop,
                          )
                        : HeaderMobile(
                            onLogoTap: scrollToTop,
                            onMenuTap: () {
                              scaffoldKey.currentState?.openEndDrawer();
                            },
                          ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void scrollToTop() {
    if (!scrollController.hasClients) return;
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
    );
  }

  void scrollToSection(int navIndex) {
    if (navIndex == 4) {
      openExternalUrl(SnsLinks.kCV);
      return;
    }

    final key = navBarKeys[navIndex];
    final renderObject = key.currentContext?.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.hasSize) return;

    final sectionTop = renderObject.localToGlobal(Offset.zero).dy;
    final headerHeight =
        (MediaQuery.sizeOf(context).width >= kMinDesktopWidth ? 80.0 : 72.0) +
        MediaQuery.paddingOf(context).top;
    final targetOffset = (scrollController.offset + sectionTop - headerHeight)
        .clamp(0.0, scrollController.position.maxScrollExtent);
    scrollController.animateTo(
      targetOffset,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
  }
}
