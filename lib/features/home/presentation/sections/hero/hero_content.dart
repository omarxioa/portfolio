import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/theme/tokens/app_radius.dart';
import '../../../../../core/theme/tokens/app_space.dart';
import 'hero_buttons.dart';

class HeroContent extends StatelessWidget {
  const HeroContent({
    super.key,
    required this.onSelectedWorkPressed,
    required this.onLetsTalkPressed,
  });

  final VoidCallback onSelectedWorkPressed;
  final VoidCallback onLetsTalkPressed;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final width = MediaQuery.sizeOf(context).width;
    final introSize = width >= 1400
        ? 76.0
        : width >= 1100
        ? 68.0
        : width >= 900
        ? 60.0
        : 46.0;
    final roleSize = width >= 1400
        ? 50.0
        : width >= 1100
        ? 44.0
        : width >= 900
        ? 40.0
        : 36.0;
    final typingSize = width >= 1200
        ? 32.0
        : width >= 900
        ? 28.0
        : 24.0;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 920),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              color: Colors.white.withValues(alpha: 0.05),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: AppColors.lime,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 7),
                Text(
                  'Available for work',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.text,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.1,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpace.md),
          Text(
            'Hi, I\'m Omar.',
            style: textTheme.displayLarge?.copyWith(
              fontSize: introSize,
              height: 0.98,
              fontWeight: FontWeight.w700,
              letterSpacing: -1.9,
            ),
          ),
          Text(
            'Mobile Software\nEngineer.',
            style: textTheme.displayMedium?.copyWith(
              fontSize: roleSize,
              height: 0.95,
              fontWeight: FontWeight.w800,
              letterSpacing: -1.9,
              color: AppColors.text,
            ),
          ),
          const SizedBox(height: AppSpace.lg),
          SizedBox(
            height: typingSize * 2.7,
            child: _CalmTypingLine(
              style: textTheme.titleMedium?.copyWith(
                color: AppColors.text,
                fontSize: typingSize,
                height: 1.26,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
              highlightStyle: textTheme.titleMedium?.copyWith(
                color: AppColors.lime,
                fontSize: typingSize,
                height: 1.26,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.4,
              ),
              cursorStyle: textTheme.titleMedium?.copyWith(
                color: AppColors.secondaryText,
                fontSize: typingSize,
                height: 1.26,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(height: AppSpace.xl),
          HeroButtons(
            onSelectedWorkPressed: onSelectedWorkPressed,
            onLetsTalkPressed: onLetsTalkPressed,
          ),
        ],
      ),
    );
  }
}

class _CalmTypingLine extends StatefulWidget {
  const _CalmTypingLine({
    required this.style,
    required this.highlightStyle,
    required this.cursorStyle,
  });

  final TextStyle? style;
  final TextStyle? highlightStyle;
  final TextStyle? cursorStyle;

  @override
  State<_CalmTypingLine> createState() => _CalmTypingLineState();
}

class _CalmTypingLineState extends State<_CalmTypingLine> {
  static const _staticPrefix = 'Building ';
  static const _typeDelay = Duration(milliseconds: 78);
  static const _deleteDelay = Duration(milliseconds: 40);
  static const _pauseAfterType = Duration(milliseconds: 1800);
  static const _pauseBeforeType = Duration(milliseconds: 420);
  static const _cursorBlink = Duration(milliseconds: 560);

  static const List<String> _phrases = [
    'products people love.',
    'offline-first experiences.',
    'scalable mobile products.',
    'delightful user experiences.',
    'reliable Flutter apps.',
  ];

  int _phraseIndex = 0;
  int _charCount = 0;
  bool _isDeleting = false;
  bool _cursorVisible = true;
  Timer? _typingTimer;
  Timer? _cursorTimer;

  @override
  void initState() {
    super.initState();
    _cursorTimer = Timer.periodic(_cursorBlink, (_) {
      if (!mounted) return;
      setState(() => _cursorVisible = !_cursorVisible);
    });
    _typingTimer = Timer(const Duration(milliseconds: 700), _tick);
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _cursorTimer?.cancel();
    super.dispose();
  }

  void _schedule(Duration delay) {
    _typingTimer?.cancel();
    _typingTimer = Timer(delay, _tick);
  }

  void _tick() {
    if (!mounted) return;

    final phrase = _phrases[_phraseIndex % _phrases.length];
    final totalLength = phrase.length;

    if (!_isDeleting) {
      if (_charCount < totalLength) {
        setState(() => _charCount++);
        _schedule(_typeDelay);
      } else {
        _schedule(_pauseAfterType);
        _isDeleting = true;
      }
      return;
    }

    if (_charCount > 0) {
      setState(() => _charCount--);
      _schedule(_deleteDelay);
      return;
    }

    _phraseIndex = (_phraseIndex + 1) % _phrases.length;
    _isDeleting = false;
    _schedule(_pauseBeforeType);
  }

  @override
  Widget build(BuildContext context) {
    final phrase = _phrases[_phraseIndex % _phrases.length];
    final visible = phrase.substring(0, _charCount.clamp(0, phrase.length));

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: _staticPrefix, style: widget.style),
          TextSpan(text: visible, style: widget.highlightStyle ?? widget.style),
          TextSpan(
            text: '|',
            style: widget.cursorStyle?.copyWith(
              color: _cursorVisible
                  ? widget.cursorStyle?.color
                  : Colors.transparent,
            ),
          ),
        ],
      ),
      maxLines: 2,
      overflow: TextOverflow.visible,
    );
  }
}
