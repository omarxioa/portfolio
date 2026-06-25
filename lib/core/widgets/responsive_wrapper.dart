import 'package:flutter/material.dart';

import '../constants/breakpoints.dart';

class ResponsiveWrapper extends StatelessWidget {
  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.mobileMaxWidth = 600,
    this.tabletMaxWidth = 900,
    this.desktopMaxWidth = 1100,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
  });

  final Widget child;
  final double mobileMaxWidth;
  final double tabletMaxWidth;
  final double desktopMaxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final maxWidth = width >= Breakpoints.tablet
            ? desktopMaxWidth
            : width >= Breakpoints.mobile
            ? tabletMaxWidth
            : mobileMaxWidth;

        return Center(
          child: Padding(
            padding: padding,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }
}
