import 'dart:ui';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_app/common.dart';

class AppBarTextInput extends HookWidget {
  const AppBarTextInput({
    Key? key,
    required this.initialValue,
    required this.onUnfocus,
    this.autoFocus = false,
  }) : super(key: key);

  final String initialValue;
  final StringCallback onUnfocus;
  final bool autoFocus;

  @override
  Widget build(BuildContext context) {
    final _f = useState(false);
    final _controller = useTextEditingController();

    useEffect(() {
      _controller.text = initialValue;
      if (autoFocus) {
        _controller.selection = TextSelection(baseOffset: 0, extentOffset: initialValue.length);
      }
    }, [initialValue]);

    return Theme(
      data: Theme.of(context).copyWith(
        textSelectionTheme: Theme.of(context).textSelectionTheme.copyWith(
              cursorColor: Colors.white,
              selectionColor: Colors.white,
            ),
      ),
      child: Focus(
        onFocusChange: (focus) {
          _f.value = focus;
          if (!focus) onUnfocus(_controller.text);
        },
        child: AutoSizeTextField(
          autocorrect: false,
          autofocus: autoFocus,
          fullwidth: true,
          selectionHeightStyle: BoxHeightStyle.includeLineSpacingTop,
          textAlign: TextAlign.center,
          onTap: () => _controller.selection = TextSelection(baseOffset: 0, extentOffset: _controller.text.length),
          controller: _controller,
          decoration: InputDecoration(
            filled: _f.value,
            fillColor: Colors.black12,
            // contentPadding: EdgeInsets.symmetric(vertical: -3),
          ),
        ),
      ),
    );
  }
}
