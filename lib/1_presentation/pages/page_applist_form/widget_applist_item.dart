import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../common.dart';

class AppListItemWidget extends StatefulWidget {
  const AppListItemWidget({
    required Key key,
    required this.initialTitle,
    required this.onUpdate,
    required this.onDelete,
    required this.autoFocus,
  }) : super(key: key);

  final String initialTitle;
  final StringCallback onUpdate;
  final VoidCallback onDelete;
  final bool autoFocus;

  @override
  _AppListItemWidgetState createState() => _AppListItemWidgetState();
}

class _AppListItemWidgetState extends State<AppListItemWidget> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialTitle);
    _focusNode = FocusNode();

    if (widget.autoFocus) _focusNode.requestFocus();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      key: widget.key,
      title: Slidable(
        endActionPane: ActionPane(
          // dismissible: DismissiblePane(onDismissed: () {}),
          children: [
            SlidableAction(
              autoClose: true,
              spacing: 0,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              onPressed: (_) {
                widget.onDelete();
              },
            ),
          ],
          motion: const ScrollMotion(),
        ),
        child: TextField(
          autocorrect: false,
          controller: _controller,
          onChanged: (value) => widget.onUpdate(value),
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
