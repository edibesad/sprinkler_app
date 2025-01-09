import 'package:flutter/material.dart';
import 'package:sprinkler_app/core/components/flip_animation.dart';

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

class _SettingsElementState extends State<SettingsElement> {
  late String subtitle;

  late void Function() _animateForward;
  late void Function() _animateReverse;

  @override
  Widget build(BuildContext context) {
    return FlipAnimation(
        onInit: (forward, reverse) {
          _animateForward = forward;
          _animateReverse = reverse;
        },
        secondChild: ListTile(
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
        firstChild: ListTile(
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
        ));
  }
}
