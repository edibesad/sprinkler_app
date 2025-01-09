import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sprinkler_app/core/extension/context_extension.dart';
import 'package:sprinkler_app/ui/device_details/view_model/device_details_view_model.dart';

class SprinklerAnimation extends StatefulWidget {
  const SprinklerAnimation({super.key, required this.viewModel});

  final DeviceDetailsViewModel viewModel;

  @override
  State<SprinklerAnimation> createState() => _SprinklerAnimationState();
}

class _SprinklerAnimationState extends State<SprinklerAnimation>
    with TickerProviderStateMixin {
  DeviceDetailsViewModel get viewModel => widget.viewModel;

  @override
  void initState() {
    super.initState();
    viewModel.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      "assets/sprinkler.json",
      height: context.height * 0.3,
      repeat: true,
      controller: viewModel.animationController,
    );
  }
}
