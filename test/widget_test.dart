import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/widgets/header_desktop.dart';
import 'package:my_portfolio/widgets/header_mobile.dart';
import 'package:my_portfolio/widgets/contact_section.dart';
import 'package:my_portfolio/widgets/project_card.dart';
import 'package:my_portfolio/utils/project_utils.dart';
import 'package:my_portfolio/widgets/site_logo.dart';
import 'package:my_portfolio/constants/size.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/widgets/projects_section.dart';
import 'package:my_portfolio/widgets/skills_desktop.dart';
import 'package:my_portfolio/widgets/skills_mobile.dart';
import 'package:my_portfolio/widgets/about_section.dart';

void main() {
  testWidgets('project cards expand to fit longer technology lists', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(320, 740);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: ProjectCardWidget(
              project: ProjectUtils(
                image: 'assets/projects/w01.png',
                title: 'Test project',
                subtitle: 'Responsive technology tags.',
                technologies: List.generate(18, (index) => 'Technology $index'),
              ),
              cardWidth: 320,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('TECHNOLOGIES'), findsOneWidget);
    expect(find.text('Technology 17'), findsOneWidget);
    final projectImage = tester.widget<Image>(
      find.descendant(
        of: find.byType(ProjectCardWidget),
        matching: find.byType(Image),
      ),
    );
    expect(projectImage.height, closeTo(230.4, 0.1));
    expect(
      tester.getSize(find.byType(ProjectCardWidget)).height,
      greaterThan(296),
    );
    final footer = tester.widget<Container>(
      find
          .ancestor(
            of: find.text('Available on:'),
            matching: find.byType(Container),
          )
          .first,
    );
    final footerDecoration = footer.decoration! as BoxDecoration;
    expect(footerDecoration.color, CustomColor.bgLight2);
    expect(
      (footerDecoration.border! as Border).top.color,
      CustomColor.whitePrimary.withValues(alpha: 0.08),
    );
    expect(
      (footer.padding! as EdgeInsets).horizontal / 2,
      closeTo(
        (tester.getSize(find.byType(ProjectCardWidget)).width * 0.04).clamp(
          12,
          24,
        ),
        0.01,
      ),
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets('About portrait loads from the converted JPEG asset', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: AboutSection())),
      ),
    );
    await tester.pumpAndSettle();

    final portrait = tester.widget<Image>(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == 'assets/profile.jpg',
      ),
    );
    expect(portrait.fit, BoxFit.contain);
    expect(tester.takeException(), isNull);
  });

  testWidgets('work projects use a two-column content-sized layout', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ProjectsSection())),
      ),
    );
    await tester.pumpAndSettle();

    final cards = find.byType(ProjectCardWidget);
    expect(cards, findsNWidgets(3));
    final firstCard = tester.getRect(cards.first);
    final secondCard = tester.getRect(cards.at(1));
    expect(firstCard.width, greaterThan(firstCard.height));
    expect(secondCard.left, greaterThan(firstCard.left));
    expect(firstCard.height, closeTo(secondCard.height, 1));
    expect(find.byTooltip('Android'), findsOneWidget);
    expect(find.byTooltip('iOS'), findsOneWidget);
    expect(find.byTooltip('Web'), findsWidgets);
    expect(tester.takeException(), isNull);
  });

  testWidgets('requested section title words use the accent color', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const Portfolio());
    await tester.pumpAndSettle();

    for (final (key, titleText, accentText) in [
      (const ValueKey('about-section-title'), 'About Me', 'Me'),
      (const ValueKey('skills-section-title'), 'Technical Skills', 'Skills'),
      (const ValueKey('projects-section-title'), 'Work Projects', 'Projects'),
    ]) {
      final richText = tester.widget<RichText>(
        find.descendant(of: find.byKey(key), matching: find.byType(RichText)),
      );
      final spans = _flattenTextSpans(richText.text as TextSpan);
      final accentSpan = spans.singleWhere((span) => span.text == accentText);

      expect((richText.text as TextSpan).toPlainText(), titleText);
      expect(accentSpan.style!.color, CustomColor.yellowPrimary);
    }

    expect(tester.takeException(), isNull);
  });

  testWidgets('skills section omits the four platform cards', (
    WidgetTester tester,
  ) async {
    for (final size in [const Size(390, 844), const Size(1280, 900)]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: size.width >= kMinDesktopWidth
                  ? const SkillsDesktop()
                  : const SkillsMobile(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      for (final platform in [
        'Android Dev',
        'Web Dev',
        'IOS Dev',
        'Desktop Dev',
      ]) {
        expect(find.text(platform), findsNothing);
      }
      for (final skill in ['Flutter', 'Dart', 'Git', 'GitHub']) {
        expect(find.text(skill), findsOneWidget);
      }
      expect(tester.takeException(), isNull);
    }
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('desktop navigation stays spaced as its viewport narrows', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1100, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderDesktop(onNavItemTap: (_) {}, onLogoTap: () {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final buttonRects = [
      for (var index = 0; index < 4; index++)
        tester.getRect(find.byType(TextButton).at(index)),
      tester.getRect(find.byType(OutlinedButton)),
    ];
    for (var index = 0; index < buttonRects.length - 1; index++) {
      expect(
        buttonRects[index].right,
        lessThanOrEqualTo(buttonRects[index + 1].left),
      );
    }
    expect(tester.takeException(), isNull);
  });

  testWidgets('desktop nav hover styles use Open Sans and animate', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1100, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: HeaderDesktop(onNavItemTap: (_) {}, onLogoTap: () {}),
        ),
      ),
    );
    await tester.pumpAndSettle();

    final projectsStyle = tester.widget<AnimatedDefaultTextStyle>(
      find.byKey(const ValueKey('nav-text-PROJECTS')),
    );
    expect(projectsStyle.style.fontFamily, 'OpenSans');
    expect(projectsStyle.style.fontSize, 15);
    expect(projectsStyle.style.fontWeight, FontWeight.w600);

    final underline = find.byKey(const ValueKey('nav-underline-PROJECTS'));
    expect(tester.getSize(underline).width, 0);
    final projectsButton = tester.getCenter(
      find.byKey(const ValueKey('nav-button-PROJECTS')),
    );
    final projectsMouseRegion = tester.widget<MouseRegion>(
      find.byKey(const ValueKey('nav-button-PROJECTS')),
    );
    projectsMouseRegion.onEnter!(PointerEnterEvent(position: projectsButton));
    await tester.pumpAndSettle();
    final hoveredProjectsStyle = tester.widget<AnimatedDefaultTextStyle>(
      find.byKey(const ValueKey('nav-text-PROJECTS')),
    );
    expect(hoveredProjectsStyle.style.color, CustomColor.yellowPrimary);
    expect(tester.getSize(underline).width, greaterThan(0));

    final resumeMouseRegion = tester.widget<MouseRegion>(
      find.byKey(const ValueKey('nav-button-RESUME')),
    );
    resumeMouseRegion.onEnter!(
      PointerEnterEvent(
        position: tester.getCenter(
          find.byKey(const ValueKey('nav-button-RESUME')),
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.pumpAndSettle();
    final resumeButton = tester.widget<OutlinedButton>(
      find.byType(OutlinedButton),
    );
    expect(
      resumeButton.style!.backgroundColor!.resolve({}),
      CustomColor.yellowPrimary,
    );
    final resumeTextStyle = tester.widget<AnimatedDefaultTextStyle>(
      find.byKey(const ValueKey('nav-text-RESUME')),
    );
    expect(resumeTextStyle.style.color, Colors.white);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact cards and social links are tappable responsively', (
    WidgetTester tester,
  ) async {
    for (final size in [
      const Size(320, 740),
      const Size(390, 844),
      const Size(580, 844),
      const Size(600, 900),
      const Size(1280, 900),
    ]) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: ContactSection())),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Let’s build something great.'), findsOneWidget);
      expect(find.text('Email me'), findsOneWidget);
      expect(find.text('WhatsApp'), findsOneWidget);
      final emailCard = find.ancestor(
        of: find.text('Email me'),
        matching: find.byType(InkWell),
      );
      final whatsappCard = find.ancestor(
        of: find.text('WhatsApp'),
        matching: find.byType(InkWell),
      );
      expect(
        tester.getSize(emailCard).width,
        closeTo(tester.getSize(whatsappCard).width, 1),
      );
      if (size.width < 580) {
        expect(tester.getSize(emailCard).width, closeTo(size.width - 56, 1));
      }
      for (final label in ['Email me', 'WhatsApp']) {
        final cardTap = find.ancestor(
          of: find.text(label),
          matching: find.byType(InkWell),
        );
        expect(cardTap, findsOneWidget);
        expect(tester.widget<InkWell>(cardTap).onTap, isNotNull);
      }
      for (final social in ['LinkedIn', 'GitHub', 'Instagram', 'Facebook']) {
        expect(find.byTooltip(social), findsOneWidget);
      }
      final initialLayoutError = tester.takeException();
      if (initialLayoutError != null) {
        debugDumpRenderTree();
        fail('$initialLayoutError at $size');
      }
    }
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('portfolio remains responsive across common viewport sizes', (
    WidgetTester tester,
  ) async {
    const viewportSizes = [
      Size(320, 568),
      Size(320, 740),
      Size(390, 844),
      Size(600, 900),
      Size(640, 900),
      Size(650, 900),
      Size(680, 900),
      Size(800, 900),
      Size(999, 900),
      Size(1000, 600),
      Size(1000, 900),
      Size(1050, 900),
      Size(1099, 900),
      Size(1100, 900),
      Size(1150, 900),
      Size(1280, 900),
      Size(1920, 1080),
    ];

    for (final size in viewportSizes) {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(const Portfolio());
      await tester.pumpAndSettle();

      expect(find.byType(SelectionArea), findsOneWidget);
      expect(find.text("Hello, I'm"), findsOneWidget);
      expect(find.byKey(const ValueKey('about-section-title')), findsOneWidget);
      expect(
        tester.getTopLeft(find.byKey(const ValueKey('about-section-title'))).dy,
        greaterThanOrEqualTo(size.height),
        reason: 'About section should start below the first viewport at $size.',
      );
      expect(find.text('View My Work'), findsOneWidget);
      expect(find.text('Contact Me'), findsOneWidget);
      expect(
        tester.getCenter(find.text("Hello, I'm")).dx,
        closeTo(size.width / 2, 2),
        reason: 'Hero content should remain centered at $size.',
      );
      expect(tester.takeException(), isNull, reason: 'Viewport: $size');

      final headerFinder = size.width >= kMinDesktopWidth
          ? find.byType(HeaderDesktop)
          : find.byType(HeaderMobile);
      final headerRect = tester.getRect(headerFinder);
      expect(headerRect.left, closeTo(0, 1), reason: 'Header at $size');
      expect(
        headerRect.right,
        closeTo(size.width, 1),
        reason: 'Header at $size',
      );

      for (var scroll = 0; scroll < 6; scroll++) {
        await tester.drag(
          find.byType(SingleChildScrollView),
          const Offset(0, -1000),
        );
        await tester.pumpAndSettle();
        expect(
          tester.takeException(),
          isNull,
          reason: 'Scroll $scroll at $size',
        );
      }
      tester
          .state<ScrollableState>(find.byType(Scrollable).first)
          .position
          .jumpTo(0);
      await tester.pumpAndSettle();
    }

    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('desktop header padding grows with viewport width', (
    WidgetTester tester,
  ) async {
    double? previousPadding;
    for (final width in [1100.0, 1280.0, 1600.0]) {
      tester.view.physicalSize = Size(width, 900);
      tester.view.devicePixelRatio = 1;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: HeaderDesktop(onNavItemTap: (_) {}, onLogoTap: () {}),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final contentPadding = tester.widget<Padding>(
        find.descendant(
          of: find.byType(HeaderDesktop),
          matching: find.byWidgetPredicate(
            (widget) => widget is Padding && widget.child is Row,
          ),
        ),
      );
      final horizontalPadding =
          (contentPadding.padding as EdgeInsets).horizontal / 2;
      if (previousPadding != null) {
        expect(horizontalPadding, greaterThan(previousPadding));
      }
      previousPadding = horizontalPadding;
      expect(tester.takeException(), isNull, reason: 'Viewport width $width');
    }
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  });

  testWidgets('mobile portfolio hero lays out without overflow', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const Portfolio());
    await tester.pumpAndSettle();

    expect(find.text("Hello, I'm"), findsOneWidget);
    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Contact Me'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Let’s build something great.')).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderMobile)).dy),
    );

    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -700),
    );
    await tester.pumpAndSettle();
    expect(scrollable.position.pixels, greaterThan(0));
    expect(find.byType(HeaderMobile), findsOneWidget);

    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    for (final icon in [
      Icons.person_outline_rounded,
      Icons.code_rounded,
      Icons.work_outline_rounded,
      Icons.mail_outline_rounded,
      Icons.description_outlined,
    ]) {
      expect(
        find.descendant(of: find.byType(Drawer), matching: find.byIcon(icon)),
        findsOneWidget,
      );
    }
    await tester.tap(find.byIcon(Icons.close));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(SiteLogo));
    await tester.pumpAndSettle();
    expect(scrollable.position.pixels, closeTo(0, 1));
    expect(tester.takeException(), isNull);
  });

  testWidgets('portfolio renders and hero CTA scrolls to contact', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const Portfolio());
    await tester.pumpAndSettle();

    expect(
      find.textContaining('Junior Flutter Developer with hands-on experience'),
      findsWidgets,
    );
    expect(find.text('Download CV'), findsOneWidget);
    expect(find.text('View My Work'), findsOneWidget);
    expect(find.text('Contact Me'), findsOneWidget);
    expect(find.text('Home'), findsNothing);
    expect(find.text('ABOUT'), findsOneWidget);
    expect(find.byKey(const ValueKey('about-section-title')), findsOneWidget);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is AssetImage &&
            (widget.image as AssetImage).assetName == 'assets/profile.jpg',
      ),
      findsOneWidget,
    );
    expect(
      find.byKey(const ValueKey('projects-section-title')),
      findsOneWidget,
    );
    expect(find.text('Hobby Projects'), findsNothing);
    expect(find.text('English Brain Craft'), findsOneWidget);
    expect(find.text('Technology 1'), findsWidgets);
    final resumeButton = tester.widget<OutlinedButton>(
      find.widgetWithText(OutlinedButton, 'RESUME'),
    );
    expect(resumeButton.style?.side, isNotNull);
    expect(find.text('Let’s build something great.'), findsOneWidget);
    expect(find.text('Email me'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(find.byType(InkWell), findsWidgets);

    await tester.tap(find.text('Contact Me'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Let’s build something great.')).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderDesktop)).dy),
    );

    await tester.tap(find.byType(SiteLogo));
    await tester.pumpAndSettle();

    await tester.tap(find.text('View My Work'));
    await tester.pumpAndSettle();

    final scrollable = tester.state<ScrollableState>(
      find.byType(Scrollable).first,
    );
    expect(scrollable.position.pixels, greaterThan(0));
    expect(find.byType(HeaderDesktop), findsOneWidget);
    expect(
      tester
          .getTopLeft(find.byKey(const ValueKey('projects-section-title')))
          .dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderDesktop)).dy),
    );
    expect(
      tester
          .getTopLeft(find.byKey(const ValueKey('projects-section-title')))
          .dy,
      lessThan(tester.getBottomLeft(find.byType(HeaderDesktop)).dy + 80),
    );
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('skills-section-title'))).dy,
      lessThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderDesktop)).dy),
    );

    await tester.tap(find.widgetWithText(TextButton, 'SKILLS'));
    await tester.pumpAndSettle();
    expect(scrollable.position.pixels, greaterThan(0));
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('skills-section-title'))).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderDesktop)).dy),
    );
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('skills-section-title'))).dy,
      lessThan(tester.getBottomLeft(find.byType(HeaderDesktop)).dy + 80),
    );

    await tester.tap(find.widgetWithText(TextButton, 'CONTACT'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.text('Let’s build something great.')).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderDesktop)).dy),
    );

    await tester.tap(find.text('ABOUT'));
    await tester.pumpAndSettle();
    expect(
      tester.getTopLeft(find.byKey(const ValueKey('about-section-title'))).dy,
      greaterThanOrEqualTo(tester.getBottomLeft(find.byType(HeaderDesktop)).dy),
    );

    await tester.tap(find.byType(SiteLogo));
    await tester.pumpAndSettle();
    expect(scrollable.position.pixels, closeTo(0, 1));
  });
}

Iterable<TextSpan> _flattenTextSpans(TextSpan span) sync* {
  yield span;
  for (final child in span.children ?? const <InlineSpan>[]) {
    if (child is TextSpan) {
      yield* _flattenTextSpans(child);
    }
  }
}
