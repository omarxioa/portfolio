import 'package:flutter/widgets.dart';

import '../../theme/tokens/app_breakpoints.dart';

class AppResponsiveLayout extends StatelessWidget {
  const AppResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
    required this.ultraWide,
  });

  final WidgetBuilder mobile;
  final WidgetBuilder tablet;
  final WidgetBuilder desktop;
  final WidgetBuilder ultraWide;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final viewport = AppBreakpoints.fromWidth(constraints.maxWidth);
        return switch (viewport) {
          AppViewport.mobile => mobile(context),
          AppViewport.tablet => tablet(context),
          AppViewport.desktop => desktop(context),
          AppViewport.ultraWide => ultraWide(context),
        };
      },
    );
  }
}
