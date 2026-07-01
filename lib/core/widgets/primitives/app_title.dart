import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppTitle extends StatelessWidget {
  const AppTitle({super.key, required this.text, this.center = false});

  final String text;
  final bool center;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontWeight: FontWeight.w700,
        letterSpacing: -0.6,
      ),
    );
  }
}

class AppSubtitle extends StatelessWidget {
  const AppSubtitle({
    super.key,
    required this.text,
    this.center = false,
    this.maxWidth,
  });

  final String text;
  final bool center;
  final double? maxWidth;

  @override
  Widget build(BuildContext context) {
    final content = Text(
      text,
      textAlign: center ? TextAlign.center : TextAlign.start,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        color: AppColors.secondaryText,
        height: 1.6,
      ),
    );

    if (maxWidth == null) return content;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth!),
      child: content,
    );
  }
}
