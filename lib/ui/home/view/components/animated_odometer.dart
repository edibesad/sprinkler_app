import 'package:flutter/material.dart';

class AnimatedOdometer extends StatefulWidget {
  final int value;
  final double digitHeight;
  final double digitWidth;
  final int numberOfDigits;
  final Duration duration;

  const AnimatedOdometer({
    super.key,
    required this.value,
    this.digitHeight = 30,
    this.digitWidth = 20,
    this.numberOfDigits = 6,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  _AnimatedOdometerState createState() => _AnimatedOdometerState();
}

class _AnimatedOdometerState extends State<AnimatedOdometer>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _animations;
  late List<int> _previousDigits;
  late List<int> _currentDigits;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(
      widget.numberOfDigits,
      (index) => AnimationController(
        duration: widget.duration,
        vsync: this,
      ),
    );

    _animations = List.generate(
      widget.numberOfDigits,
      (index) => CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.easeInOutCubic,
      ),
    );

    _previousDigits = _getDigits(widget.value);
    _currentDigits = _previousDigits;
  }

  List<int> _getDigits(int number) {
    String padded = number.toString().padLeft(widget.numberOfDigits, '0');
    return padded.split('').map(int.parse).toList();
  }

  @override
  void didUpdateWidget(AnimatedOdometer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _previousDigits = _currentDigits;
      _currentDigits = _getDigits(widget.value);

      for (var i = 0; i < widget.numberOfDigits; i++) {
        if (_previousDigits[i] != _currentDigits[i]) {
          _controllers[i].forward(from: 0);
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(4),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "%",
            style: TextStyle(color: Colors.white, fontFamily: 'monospace'),
          ),
          ...List.generate(
            widget.numberOfDigits,
            (index) => _buildDigit(index),
          )
        ],
      ),
    );
  }

  Widget _buildDigit(int index) {
    return SizedBox(
      // Changed from Container to SizedBox for fixed dimensions
      width: widget.digitWidth,
      height: widget.digitHeight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: const Color(0xFF222222),
          borderRadius: BorderRadius.circular(2),
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        // Add clipBehavior here as well
        clipBehavior: Clip.antiAlias,
        child: AnimatedBuilder(
          animation: _animations[index],
          builder: (context, child) {
            return Stack(
              children: [
                _buildDigitRoller(
                  index,
                  _previousDigits[index],
                  _currentDigits[index],
                  _animations[index].value,
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.5),
                        Colors.transparent,
                        Colors.transparent,
                        Colors.black.withOpacity(0.5),
                      ],
                      stops: const [0.0, 0.2, 0.8, 1.0],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildDigitRoller(
      int index, int previousDigit, int currentDigit, double animationValue) {
    return SingleChildScrollView(
      // Added to handle potential overflow
      physics: const NeverScrollableScrollPhysics(),
      child: Transform.translate(
        offset: Offset(0, -widget.digitHeight * animationValue),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDigitText(previousDigit),
            _buildDigitText(currentDigit),
          ],
        ),
      ),
    );
  }

  Widget _buildDigitText(int digit) {
    return SizedBox(
      // Changed from Container to SizedBox for fixed dimensions
      height: widget.digitHeight,
      width: widget.digitWidth,
      child: Center(
        // Changed from Container to Center
        child: Text(
          digit.toString(),
          style: TextStyle(
            fontSize: widget.digitHeight * 0.7,
            fontWeight: FontWeight.bold,
            color: const Color(0xFFE0E0E0),
            fontFamily: 'monospace',
          ),
        ),
      ),
    );
  }
}
