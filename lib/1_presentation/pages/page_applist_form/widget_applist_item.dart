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
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: widget.initialTitle);
    _focusNode = FocusNode();
    if (widget.autoFocus) _focusNode.requestFocus();

    _focusNode.addListener(
      () {
        if (_focusNode.hasFocus) return;

        if (!_isDeleting) {
          widget.onUpdate(_controller.text);
        }
      },
    );
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
                _isDeleting = true;
                widget.onDelete();
                FocusScope.of(context).unfocus();
              },
            ),
          ],
          motion: const ScrollMotion(),
        ),
        child: TextField(
          autocorrect: false,
          controller: _controller,
          focusNode: _focusNode,
        ),
      ),
    );
  }
}
