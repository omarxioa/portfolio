import 'package:flutter/material.dart';

import '../../theme/tokens/motion.dart';

class AppHover extends StatefulWidget {
  const AppHover({
    super.key,
    required this.child,
    this.translate = const Offset(0, -4),
  });

  final Widget child;
  final Offset translate;

  @override
  State<AppHover> createState() => _AppHoverState();
}

class _AppHoverState extends State<AppHover> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedSlide(
        duration: Motion.fast,
        curve: Motion.standard,
        offset: _hovered
            ? Offset(widget.translate.dx / 100, widget.translate.dy / 100)
            : Offset.zero,
        child: widget.child,
      ),
    );
  }
}

class AppReveal extends StatefulWidget {
  const AppReveal({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.beginOffset = const Offset(0, 0.08),
  });

  final Widget child;
  final Duration delay;
  final Offset beginOffset;

  @override
  State<AppReveal> createState() => _AppRevealState();
}

class _AppRevealState extends State<AppReveal> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(widget.delay, () {
      if (mounted) setState(() => _visible = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _visible ? Offset.zero : widget.beginOffset,
      duration: Motion.slow,
      curve: Motion.emphasized,
      child: AnimatedOpacity(
        opacity: _visible ? 1 : 0,
        duration: Motion.slow,
        curve: Motion.standard,
        child: widget.child,
      ),
    );
  }
}
