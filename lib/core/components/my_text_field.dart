import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MyTextField extends TextField {
  MyTextField({
    super.key,
    this.labelText,
    super.controller,
    super.focusNode,
    super.autofocus,
    super.obscureText = false,
    super.autocorrect = true,
    super.enableSuggestions = true,
    super.textInputAction,
    super.textCapitalization = TextCapitalization.none,
    super.style,
    super.textAlign = TextAlign.start,
    super.textDirection,
    super.readOnly = false,
    super.toolbarOptions,
    super.showCursor,
    super.autofillHints,
    super.maxLines = 1,
    super.minLines,
    super.expands = false,
    super.maxLength,
    super.maxLengthEnforcement,
    super.onChanged,
    super.onEditingComplete,
    super.onSubmitted,
    super.inputFormatters,
    super.enabled,
    super.cursorWidth = 2.0,
    super.cursorHeight,
    super.cursorRadius,
    super.cursorColor,
    super.keyboardAppearance,
    super.scrollPadding = const EdgeInsets.all(20.0),
    super.dragStartBehavior = DragStartBehavior.start,
    super.enableInteractiveSelection = true,
    super.onTap,
    super.buildCounter,
    super.scrollController,
    super.scrollPhysics,
    super.keyboardType,
    super.canRequestFocus = true,
    super.clipBehavior,
  }) : super(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );

  final String? labelText;
}
