import 'package:flutter/material.dart';
import 'package:my_portfolio/constants/colors.dart';
import 'package:my_portfolio/constants/nav_items.dart';
import 'package:my_portfolio/widgets/site_logo.dart';

class HeaderDesktop extends StatelessWidget {
  const HeaderDesktop({
    super.key,
    required this.onNavItemTap,
    required this.onLogoTap,
  });

  final Function(int) onNavItemTap;
  final VoidCallback onLogoTap;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isCompact = screenWidth < 1200;
    final horizontalPadding = (screenWidth * 0.055).clamp(
      isCompact ? 12.0 : 40.0,
      84.0,
    );
    final navigationGap = isCompact ? 2.0 : 12.0;
    return Container(
      color: CustomColor.scaffoldBg.withValues(alpha: 0.97),
      height: 80,
      width: double.infinity,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding.clamp(
                    isCompact ? 12 : 20,
                    constraints.maxWidth / 2,
                  ),
                ),
                child: Row(
                  children: [
                    if (isCompact)
                      SizedBox(
                        width: 120,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: SiteLogo(onTap: onLogoTap),
                        ),
                      )
                    else
                      SiteLogo(onTap: onLogoTap),
                    const Spacer(),
                    _buildNavigation(
                      isCompact: isCompact,
                      navigationGap: navigationGap,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNavigation({
    required bool isCompact,
    required double navigationGap,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < navTitles.length; i++)
          Padding(
            padding: EdgeInsets.only(left: i == 0 ? 0 : navigationGap),
            child: _buildNavigationButton(i, isCompact),
          ),
      ],
    );
  }

  Widget _buildNavigationButton(int index, bool isCompact) {
    return index == navTitles.length - 1
        ? _ResumeNavigationButton(
            title: navTitles[index],
            isCompact: isCompact,
            onPressed: () => onNavItemTap(index),
          )
        : _NavigationTextButton(
            title: navTitles[index],
            isCompact: isCompact,
            onPressed: () => onNavItemTap(index),
          );
  }
}

class _NavigationTextButton extends StatefulWidget {
  const _NavigationTextButton({
    required this.title,
    required this.isCompact,
    required this.onPressed,
  });

  final String title;
  final bool isCompact;
  final VoidCallback onPressed;

  @override
  State<_NavigationTextButton> createState() => _NavigationTextButtonState();
}

class _NavigationTextButtonState extends State<_NavigationTextButton> {
  bool _isHovered = false;
  bool _hasFocus = false;

  void _setHovered(bool hovered) {
    if (_isHovered != hovered) {
      setState(() => _isHovered = hovered);
    }
  }

  void _setFocused(bool focused) {
    if (_hasFocus != focused) {
      setState(() => _hasFocus = focused);
    }
  }

  bool get _isHighlighted => _isHovered || _hasFocus;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 15,
      fontWeight: FontWeight.w600,
    );

    return FocusableActionDetector(
      onShowFocusHighlight: _setFocused,
      child: MouseRegion(
        key: ValueKey('nav-button-${widget.title}'),
        onEnter: (_) => _setHovered(true),
        onExit: (_) => _setHovered(false),
        child: TextButton(
          onPressed: widget.onPressed,
          style: TextButton.styleFrom(
            animationDuration: const Duration(milliseconds: 180),
            foregroundColor: CustomColor.whitePrimary,
            overlayColor: Colors.transparent,
            visualDensity: widget.isCompact
                ? const VisualDensity(horizontal: -4)
                : VisualDensity.standard,
            padding: EdgeInsets.symmetric(
              horizontal: widget.isCompact ? 0 : 12,
              vertical: 10,
            ),
            minimumSize: const Size(0, 48),
            textStyle: textStyle,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimatedDefaultTextStyle(
                key: ValueKey('nav-text-${widget.title}'),
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                style: textStyle.copyWith(
                  color: _isHighlighted
                      ? CustomColor.yellowPrimary
                      : CustomColor.whitePrimary,
                ),
                child: Text(widget.title),
              ),
              const SizedBox(height: 3),
              AnimatedContainer(
                key: ValueKey('nav-underline-${widget.title}'),
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: _isHighlighted ? widget.title.length * 7.5 : 0,
                height: 2,
                color: CustomColor.yellowPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ResumeNavigationButton extends StatefulWidget {
  const _ResumeNavigationButton({
    required this.title,
    required this.isCompact,
    required this.onPressed,
  });

  final String title;
  final bool isCompact;
  final VoidCallback onPressed;

  @override
  State<_ResumeNavigationButton> createState() =>
      _ResumeNavigationButtonState();
}

class _ResumeNavigationButtonState extends State<_ResumeNavigationButton> {
  bool _isHovered = false;
  bool _hasFocus = false;

  void _setHovered(bool hovered) {
    if (_isHovered != hovered) {
      setState(() => _isHovered = hovered);
    }
  }

  void _setFocused(bool focused) {
    if (_hasFocus != focused) {
      setState(() => _hasFocus = focused);
    }
  }

  bool get _isHighlighted => _isHovered || _hasFocus;

  @override
  Widget build(BuildContext context) {
    final textColor = _isHighlighted ? Colors.white : CustomColor.yellowPrimary;
    return FocusableActionDetector(
      onShowFocusHighlight: _setFocused,
      child: MouseRegion(
        key: ValueKey('nav-button-${widget.title}'),
        onEnter: (_) => _setHovered(true),
        onExit: (_) => _setHovered(false),
        child: OutlinedButton(
          onPressed: widget.onPressed,
          style: OutlinedButton.styleFrom(
            animationDuration: const Duration(milliseconds: 180),
            foregroundColor: textColor,
            backgroundColor: _isHighlighted
                ? CustomColor.yellowPrimary
                : Colors.transparent,
            overlayColor: Colors.transparent,
            side: BorderSide(
              color: _isHighlighted
                  ? CustomColor.yellowPrimary
                  : CustomColor.yellowPrimary.withValues(alpha: 0.75),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: widget.isCompact ? 4 : 12,
              vertical: 10,
            ),
            visualDensity: widget.isCompact
                ? const VisualDensity(horizontal: -4)
                : VisualDensity.standard,
            minimumSize: const Size(0, 48),
            textStyle: const TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
          child: AnimatedDefaultTextStyle(
            key: ValueKey('nav-text-${widget.title}'),
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            style: TextStyle(
              fontFamily: 'OpenSans',
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
            child: Text(widget.title),
          ),
        ),
      ),
    );
  }
}
