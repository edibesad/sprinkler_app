import 'package:flutter/material.dart';

class ConfigurationComponent extends StatefulWidget {
  const ConfigurationComponent({
    super.key,
    required this.child,
    this.enabled = true,
    this.onCheckboxChanged,
  });
  final bool enabled;
  final Widget child;
  final void Function(bool value)? onCheckboxChanged;
  @override
  State<ConfigurationComponent> createState() => _ConfigurationComponentState();
}

class _ConfigurationComponentState extends State<ConfigurationComponent> {
  late bool enabled;

  @override
  void initState() {
    super.initState();
    enabled = widget.enabled;
  }

  _checkBoxOnChanged(bool? value) {
    setState(() {
      widget.onCheckboxChanged?.call(value!);
      enabled = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: ColorFiltered(
                    colorFilter: ColorFilter.matrix(
                      enabled
                          ? [
                              1,
                              0,
                              0,
                              0,
                              0,
                              0,
                              1,
                              0,
                              0,
                              0,
                              0,
                              0,
                              1,
                              0,
                              0,
                              0,
                              0,
                              0,
                              1,
                              0
                            ]
                          : [
                              0.2126,
                              0.7152,
                              0.0722,
                              0,
                              0,
                              0.2126,
                              0.7152,
                              0.0722,
                              0,
                              0,
                              0.2126,
                              0.7152,
                              0.0722,
                              0,
                              0,
                              0,
                              0,
                              0,
                              1,
                              0
                            ],
                    ),
                    child: widget.child),
              ),
            ],
          ),
          if (!enabled)
            Positioned.fill(child: Container(color: Colors.transparent)),
          Align(
              alignment: Alignment.topLeft,
              child: Checkbox(value: enabled, onChanged: _checkBoxOnChanged)),
        ],
      ),
    );
  }
}
