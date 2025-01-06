import 'dart:math';

import 'package:flutter/material.dart';

class SettingsElement extends StatefulWidget {
  const SettingsElement({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.subtitle,
    this.onSave,
    this.onCancel,
  });

  final Widget icon;
  final String title;
  final Widget? subtitle;
  final Widget child;
  final Function()? onSave;
  final Function()? onCancel;
  @override
  State<SettingsElement> createState() => _SettingsElementState();
}

class _SettingsElementState extends State<SettingsElement>
    with SingleTickerProviderStateMixin {
  late String subtitle;
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
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, _) {
        if (!_isChanged &&
            _controller.value >= 0.4 &&
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
              ? Transform.flip(
                  flipY: true,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: widget.icon,
                    ),
                    title: widget.child,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.onSave != null)
                          IconButton(
                              onPressed: () {
                                widget.onSave?.call();
                                _animateReverse();
                              },
                              icon: const Icon(Icons.done)),
                        IconButton(
                            onPressed: () {
                              widget.onCancel?.call();
                              _animateReverse();
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    onTap: () {
                      _animateReverse();
                    },
                  ),
                )
              : ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: widget.icon,
                  ),
                  title: Text(widget.title),
                  subtitle: widget.subtitle,
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    _animateForward();
                  },
                ),
        );
      },
      animation: _controller,
    );
  }
}
