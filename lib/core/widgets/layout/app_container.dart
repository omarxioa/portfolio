import 'package:flutter/material.dart';

import '../../theme/tokens/app_breakpoints.dart';

class AppContainer extends StatelessWidget {
  final Widget child;

  const AppContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final viewport = AppBreakpoints.fromWidth(width);
    final spec = AppGrid.spec(viewport);

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: spec.maxWidth),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: spec.horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
