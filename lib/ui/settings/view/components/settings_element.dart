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
  bool flipped = false;
  late final AnimationController _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, _) {
        if (_controller.value == 0.5) {
          flipped = !flipped;
        }

        return Transform(
          alignment: Alignment.center,
          transform:
              Matrix4.rotationX(_controller.value * pi * (flipped ? 1 : -1)),
          child: flipped
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
                                _controller.reverse(from: 1.0);
                              },
                              icon: const Icon(Icons.done)),
                        IconButton(
                            onPressed: () {
                              widget.onCancel?.call();
                              _controller.reverse(from: 1.0);
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    onTap: () {
                      _controller.reverse(from: 1.0);
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
                    _controller.forward(from: 0.0);
                  },
                ),
        );
      },
      animation: _controller,
    );
  }
}
