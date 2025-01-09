import 'dart:math';

import 'package:flutter/widgets.dart';

class FlipAnimation extends StatefulWidget {
  const FlipAnimation(
      {super.key,
      required this.firstChild,
      required this.secondChild,
      this.onInit});

  final Widget firstChild;
  final Widget secondChild;
  final void Function(
      void Function() animateForward, void Function() animateReverse)? onInit;
  @override
  State<FlipAnimation> createState() => _FlipAnimationState();
}

class _FlipAnimationState extends State<FlipAnimation>
    with SingleTickerProviderStateMixin {
  bool _flipped = false;
  bool _isChanged = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );

  final double animatationValue = 1;

  void _animateForward() {
    _controller.forward(from: 0);
  }

  void _animateReverse() {
    _controller.reverse(from: animatationValue);
  }

  @override
  void initState() {
    super.initState();

    widget.onInit?.call(_animateForward, _animateReverse);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, _) {
        if (!_isChanged &&
            _controller.value >= 0.45 &&
            _controller.value <= 0.5) {
          _flipped = !_flipped;
          _isChanged = true;
        }
        if (_controller.value == 0.0 || _controller.value == 1.0) {
          _isChanged = false;
        }

        return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.rotationX(_controller.value * pi * (_flipped ? 1 : -1)),
          child: _flipped
              ? Transform.flip(flipY: true, child: widget.secondChild)
              : widget.firstChild,
        );
      },
      animation: _controller,
    );
  }
}
