import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../theme/tokens/app_radius.dart';
import '../../theme/tokens/app_space.dart';
import '../../theme/tokens/motion.dart';

enum AppButtonVariant { primary, secondary }

class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.secondary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isPrimary = widget.variant == AppButtonVariant.primary;
    final isDisabled = widget.onPressed == null;
    final style = OutlinedButton.styleFrom(
      foregroundColor: isDisabled
          ? AppColors.secondaryText.withValues(alpha: 0.7)
          : isPrimary
          ? Colors.black
          : AppColors.text,
      backgroundColor: isPrimary
          ? isDisabled
                ? AppColors.lime.withValues(alpha: 0.35)
                : AppColors.lime.withValues(alpha: _isHovered ? 0.92 : 1)
          : isDisabled
          ? Colors.white.withValues(alpha: 0.02)
          : Colors.white.withValues(alpha: _isHovered ? 0.08 : 0.03),
      side: BorderSide(
        color: isPrimary
            ? isDisabled
                  ? AppColors.lime.withValues(alpha: 0.2)
                  : AppColors.lime.withValues(alpha: _isHovered ? 0.92 : 1)
            : isDisabled
            ? Colors.white.withValues(alpha: 0.12)
            : Colors.white.withValues(alpha: _isHovered ? 0.42 : 0.24),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpace.lg + AppSpace.xs,
        vertical: AppSpace.md,
      ),
      textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
      ),
      animationDuration: Motion.fast,
      elevation: 0,
    );

    final buttonChild = widget.icon == null
        ? OutlinedButton(
            onPressed: widget.onPressed,
            style: style,
            child: Text(widget.label),
          )
        : OutlinedButton.icon(
            onPressed: widget.onPressed,
            icon: Icon(widget.icon, size: 18),
            label: Text(widget.label),
            style: style,
          );

    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: isDisabled ? null : (_) => setState(() => _isHovered = true),
      onExit: isDisabled ? null : (_) => setState(() => _isHovered = false),
      child: AnimatedScale(
        duration: Motion.fast,
        curve: Curves.easeOutCubic,
        scale: _isHovered && !isDisabled ? 1.02 : 1,
        child: buttonChild,
      ),
    );
  }
}
