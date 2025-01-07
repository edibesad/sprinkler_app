import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  final String text;
  final IconData icon1;
  final IconData icon2;
  final VoidCallback onPressed;

  const MyButton({
    super.key,
    required this.text,
    required this.icon1,
    required this.icon2,
    required this.onPressed,
  });

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  bool _isPressed = false;

  void _handlePress() {
    setState(() => _isPressed = true);
    widget.onPressed();

    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        setState(() => _isPressed = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(),
      onPressed: _handlePress,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.text),
            const SizedBox(width: 8),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              child: Icon(
                _isPressed ? widget.icon2 : widget.icon1,
                key: ValueKey(_isPressed),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
