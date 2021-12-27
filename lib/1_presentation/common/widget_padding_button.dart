import 'package:flutter/material.dart';

class PaddingButton extends StatelessWidget {
  const PaddingButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.ac_unit_rounded),
      onPressed: () {},
      color: Colors.transparent,
      enableFeedback: false,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }
}
