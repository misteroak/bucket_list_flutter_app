import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common.dart';

class AppListItemWidget extends HookWidget {
  const AppListItemWidget(
      {Key? key,
      required this.index,
      required this.initialTitle,
      required this.autoFocus,
      required this.onUpdate,
      required this.onDelete})
      : super(key: key);

  final int index;
  final String initialTitle;
  final bool autoFocus;
  final StringCallback onUpdate;
  final IntCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final _controller = useTextEditingController(text: initialTitle);

    final _focusNode = useFocusNode(debugLabel: key.toString());

    useEffect(() {
      _focusNode.addListener(
        () {
          debugPrint(
              '${_focusNode.debugLabel} has ${_focusNode.hasFocus ? '' : 'lost'} focus');

          if (!_focusNode.hasFocus) {
            onUpdate(_controller.value.text);
          }
        },
      );

      if (autoFocus) {
        _focusNode.requestFocus();
      }
    }, [_focusNode]);

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        title: TextField(
          controller: _controller,
          focusNode: _focusNode,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            _focusNode.removeListener(() {});
            _focusNode.unfocus();
            onDelete(index);
          },
        ),
      ),
    );
  }
}
