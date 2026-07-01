import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/tokens/app_blur.dart';
import '../../theme/tokens/app_radius.dart';
import '../../theme/tokens/app_space.dart';

class AppGlass extends StatelessWidget {
  const AppGlass({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpace.lg),
    this.showBorder = true,
    this.backgroundColor,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool showBorder;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.large),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: AppBlur.soft, sigmaY: AppBlur.soft),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor ?? Colors.white.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(AppRadius.large),
            border: showBorder ? Border.all(color: Colors.white12) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}
