import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CreateNewListWidget extends HookWidget {
  const CreateNewListWidget({required this.onClick, Key? key})
      : super(key: key);
  final void Function(String string) onClick;

  @override
  Widget build(BuildContext context) {
    final formHook = useTextEditingController();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: TextFormField(
            controller: formHook,
          ),
        ),
        Expanded(
          flex: 1,
          child: TextButton(
            onPressed: () => onClick(formHook.value.text),
            child: const Text('Add'),
          ),
        ),
      ],
    );
  }
}
