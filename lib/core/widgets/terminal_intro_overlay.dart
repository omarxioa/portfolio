import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../constants/app_data.dart';

enum TerminalIntroStyle { modern, classicCmd }

class TerminalIntroOverlay extends StatefulWidget {
  const TerminalIntroOverlay({
    super.key,
    required this.onFinish,
    this.style = TerminalIntroStyle.modern,
  });

  final VoidCallback onFinish;
  final TerminalIntroStyle style;

  @override
  State<TerminalIntroOverlay> createState() => _TerminalIntroOverlayState();
}

class _TerminalIntroOverlayState extends State<TerminalIntroOverlay>
    with SingleTickerProviderStateMixin {
  static const int _typedLinesFromEnd = 2;

  static const List<String> _modernScript = [
    'myphz@archlinux:~\$ pwd',
    '/home/daniel/Documents',
    'myphz@archlinux:~\$ cd portfolio',
    'myphz@archlinux:~/portfolio\$ ls',
    'analysis_options.yaml  pubspec.yaml  README.md  lib/  assets/  web/',
    'myphz@archlinux:~/portfolio\$ flutter pub get',
    'Resolving dependencies... done',
    'myphz@archlinux:~/portfolio\$ flutter run -d chrome',
    'Launching lib/main.dart on Chrome in debug mode...',
  ];

  late final AnimationController _blinkController;
  Timer? _typingTimer;
  int _lineIndex = 0;
  int _charIndex = 0;
  bool _finishing = false;
  bool _isTypingChars = true;

  List<String> get _script {
    if (widget.style == TerminalIntroStyle.modern) {
      return _modernScript;
    }

    final user = AppData.name.split(' ').first.toLowerCase();
    return [
      '$user@archlinux:\$ pwd',
      '/home/$user/Documents',
      '$user@archlinux:\$ cd portfolio',
      '$user@archlinux:~/portfolio\$ ls',
      'analysis_options.yaml  pubspec.yaml  README.md  lib/  assets/  web/',
      'android/  ios/  macos/  test/  build/',
      '$user@archlinux:~/portfolio\$ flutter pub get',
      'Resolving dependencies... done',
      '$user@archlinux:~/portfolio\$ flutter run -d chrome',
      'Launching lib/main.dart on Chrome in debug mode...',
    ];
  }

  String get _currentFullLine => _script[_lineIndex];

  List<String> get _completedLines => _script.take(_lineIndex).toList();

  String get _currentLine => _currentFullLine.substring(0, _charIndex);

  _IntroPalette get _palette {
    switch (widget.style) {
      case TerminalIntroStyle.classicCmd:
        return _IntroPalette(
          overlay: const Color(0xFF000000),
          panel: const Color(0x00000000),
          border: const Color(0x00000000),
          titleBar: const Color(0x00000000),
          titleBarText: const Color(0xFF66FF66),
          text: const Color(0xFF66FF66),
          muted: const Color(0xCC66FF66),
          cursor: const Color(0xFF8AFF8A),
          showWindowDots: false,
          title: '',
          fullscreen: true,
        );
      case TerminalIntroStyle.modern:
        return _IntroPalette(
          overlay: AppColors.background.withValues(alpha: 0.96),
          panel: const Color(0xFF0B0F14),
          border: AppColors.primary.withValues(alpha: 0.25),
          titleBar: const Color(0x00000000),
          titleBarText: AppColors.secondaryText,
          text: AppColors.text,
          muted: AppColors.secondaryText,
          cursor: AppColors.primary,
          showWindowDots: true,
          title: 'terminal',
          fullscreen: false,
        );
    }
  }

  @override
  void initState() {
    super.initState();
    _lineIndex = (_script.length - _typedLinesFromEnd).clamp(0, _script.length);
    _charIndex = 0;

    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _typingTimer = Timer.periodic(const Duration(milliseconds: 80), _onTick);
  }

  @override
  void dispose() {
    _typingTimer?.cancel();
    _blinkController.dispose();
    super.dispose();
  }

  void _onTick(Timer timer) {
    if (!mounted || _finishing) return;

    if (_charIndex < _currentFullLine.length) {
      setState(() {
        _isTypingChars = true;
        _charIndex += 1;
      });
      return;
    }

    if (_lineIndex < _script.length - 1) {
      timer.cancel();
      setState(() {
        _isTypingChars = false;
      });
      Future<void>.delayed(const Duration(milliseconds: 170), () {
        if (!mounted || _finishing) return;
        setState(() {
          _isTypingChars = true;
          _lineIndex += 1;
          _charIndex = 0;
        });
        _typingTimer = Timer.periodic(
          const Duration(milliseconds: 70),
          _onTick,
        );
      });
      return;
    }

    _startFinish();
  }

  void _startFinish() {
    if (_finishing) return;
    _finishing = true;
    _isTypingChars = false;
    _typingTimer?.cancel();

    Future<void>.delayed(const Duration(milliseconds: 450), () {
      if (mounted) {
        widget.onFinish();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final palette = _palette;
    final isClassic = widget.style == TerminalIntroStyle.classicCmd;
    final terminalLetterSpacing = isClassic ? -0.35 : -0.1;
    final terminalFontFamily = isClassic ? 'Courier New' : 'monospace';
    final terminalFontFallback = isClassic
        ? const ['Consolas', 'Menlo', 'Courier New', 'monospace']
        : const ['monospace'];

    return Material(
      color: palette.overlay,
      child: SafeArea(
        child: Stack(
          children: [
            Positioned(
              bottom: 12,
              right: 14,
              child: TextButton.icon(
                onPressed: _startFinish,
                icon: const Icon(Icons.fast_forward_rounded, size: 18),
                label: const Text('Skip Animation'),
                style: TextButton.styleFrom(foregroundColor: palette.muted),
              ),
            ),
            Align(
              alignment: palette.fullscreen
                  ? Alignment.topLeft
                  : Alignment.center,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1120),
                child: Container(
                  margin: EdgeInsets.fromLTRB(
                    18,
                    palette.fullscreen ? 58 : 18,
                    18,
                    18,
                  ),
                  padding: EdgeInsets.all(palette.fullscreen ? 0 : 20),
                  decoration: BoxDecoration(
                    color: palette.panel,
                    borderRadius: BorderRadius.circular(
                      palette.fullscreen ? 0 : 14,
                    ),
                    border: Border.all(color: palette.border),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!palette.fullscreen)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 7,
                          ),
                          decoration: BoxDecoration(
                            color: palette.titleBar,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              if (palette.showWindowDots) ...[
                                _Dot(color: Colors.red.shade400),
                                const SizedBox(width: 6),
                                _Dot(color: Colors.amber.shade400),
                                const SizedBox(width: 6),
                                _Dot(color: Colors.green.shade400),
                              ],
                              if (palette.showWindowDots) const Spacer(),
                              Text(
                                palette.title,
                                style: textTheme.labelMedium?.copyWith(
                                  color: palette.titleBarText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      if (!palette.fullscreen) const SizedBox(height: 14),
                      for (final line in _completedLines)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            line,
                            style: textTheme.bodyMedium?.copyWith(
                              color: palette.text,
                              fontFamily: terminalFontFamily,
                              fontFamilyFallback: terminalFontFallback,
                              fontWeight: isClassic
                                  ? FontWeight.w600
                                  : FontWeight.w400,
                              letterSpacing: terminalLetterSpacing,
                              fontSize: palette.fullscreen ? 16 : null,
                              height: 1.35,
                            ),
                          ),
                        ),
                      AnimatedBuilder(
                        animation: _blinkController,
                        builder: (context, _) {
                          return RichText(
                            text: TextSpan(
                              style: textTheme.bodyMedium?.copyWith(
                                color: palette.text,
                                fontFamily: terminalFontFamily,
                                fontFamilyFallback: terminalFontFallback,
                                fontWeight: isClassic
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                letterSpacing: terminalLetterSpacing,
                                fontSize: palette.fullscreen ? 16 : null,
                                height: 1.35,
                              ),
                              children: [
                                TextSpan(text: _currentLine),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.baseline,
                                  baseline: TextBaseline.alphabetic,
                                  child: Transform.translate(
                                    offset: Offset(
                                      widget.style ==
                                                  TerminalIntroStyle
                                                      .classicCmd &&
                                              _isTypingChars
                                          ? (_blinkController.value - 0.5) * 1.2
                                          : 0,
                                      0,
                                    ),
                                    child: Container(
                                      width: isClassic ? 2.0 : 1.8,
                                      height:
                                          (palette.fullscreen ? 16 : 15) * 1.15,
                                      color: palette.cursor.withValues(
                                        alpha:
                                            widget.style ==
                                                TerminalIntroStyle.classicCmd
                                            ? (_isTypingChars
                                                  ? 0.76 +
                                                        _blinkController.value *
                                                            0.24
                                                  : 0.2 +
                                                        _blinkController.value *
                                                            0.8)
                                            : 0.45 +
                                                  _blinkController.value * 0.55,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IntroPalette {
  const _IntroPalette({
    required this.overlay,
    required this.panel,
    required this.border,
    required this.titleBar,
    required this.titleBarText,
    required this.text,
    required this.muted,
    required this.cursor,
    required this.showWindowDots,
    required this.title,
    required this.fullscreen,
  });

  final Color overlay;
  final Color panel;
  final Color border;
  final Color titleBar;
  final Color titleBarText;
  final Color text;
  final Color muted;
  final Color cursor;
  final bool showWindowDots;
  final String title;
  final bool fullscreen;
}

class _Dot extends StatelessWidget {
  const _Dot({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
