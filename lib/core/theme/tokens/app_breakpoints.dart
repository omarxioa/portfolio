enum AppViewport { mobile, tablet, desktop, ultraWide }

abstract final class AppBreakpoints {
  static const double mobile = 0;
  static const double tablet = 720;
  static const double desktop = 1100;
  static const double ultraWide = 1600;

  static AppViewport fromWidth(double width) {
    if (width >= ultraWide) return AppViewport.ultraWide;
    if (width >= desktop) return AppViewport.desktop;
    if (width >= tablet) return AppViewport.tablet;
    return AppViewport.mobile;
  }
}

class GridSpec {
  const GridSpec({
    required this.columns,
    required this.gutter,
    required this.maxWidth,
    required this.horizontalPadding,
  });

  final int columns;
  final double gutter;
  final double maxWidth;
  final double horizontalPadding;
}

abstract final class AppGrid {
  static GridSpec spec(AppViewport viewport) {
    switch (viewport) {
      case AppViewport.mobile:
        return const GridSpec(
          columns: 4,
          gutter: 12,
          maxWidth: 520,
          horizontalPadding: 16,
        );
      case AppViewport.tablet:
        return const GridSpec(
          columns: 8,
          gutter: 16,
          maxWidth: 980,
          horizontalPadding: 24,
        );
      case AppViewport.desktop:
        return const GridSpec(
          columns: 12,
          gutter: 20,
          maxWidth: 1240,
          horizontalPadding: 32,
        );
      case AppViewport.ultraWide:
        return const GridSpec(
          columns: 16,
          gutter: 24,
          maxWidth: 1540,
          horizontalPadding: 40,
        );
    }
  }
}
