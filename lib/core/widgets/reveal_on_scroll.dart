import 'package:flutter/material.dart';

class RevealOnScroll extends StatefulWidget {
  const RevealOnScroll({
    super.key,
    required this.controller,
    required this.child,
    this.duration = const Duration(milliseconds: 650),
    this.delay = Duration.zero,
    this.beginOffset = const Offset(0, 0.08),
  });

  final ScrollController controller;
  final Widget child;
  final Duration duration;
  final Duration delay;
  final Offset beginOffset;

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _revealed = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkVisibility);
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
  }

  @override
  void didUpdateWidget(covariant RevealOnScroll oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_checkVisibility);
      widget.controller.addListener(_checkVisibility);
      WidgetsBinding.instance.addPostFrameCallback((_) => _checkVisibility());
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkVisibility);
    super.dispose();
  }

  void _checkVisibility() {
    if (!mounted || _revealed) return;

    final object = context.findRenderObject();
    if (object is! RenderBox || !object.attached) return;

    final viewportHeight = MediaQuery.sizeOf(context).height;
    final top = object.localToGlobal(Offset.zero).dy;
    final bottom = top + object.size.height;

    final isVisible =
        top < viewportHeight * 0.9 && bottom > viewportHeight * 0.05;
    if (!isVisible) return;

    if (widget.delay == Duration.zero) {
      setState(() => _revealed = true);
      return;
    }

    Future<void>.delayed(widget.delay, () {
      if (mounted) {
        setState(() => _revealed = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: _revealed ? Offset.zero : widget.beginOffset,
      duration: widget.duration,
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        opacity: _revealed ? 1 : 0,
        duration: widget.duration,
        curve: Curves.easeOut,
        child: widget.child,
      ),
    );
  }
}
