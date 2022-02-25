import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final TextEditingController controller;
  const NameTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      maxLength: 40,
      autocorrect: true,
      autofocus: true,
      onEditingComplete: () {},
      onSubmitted: (value) {},
      decoration: InputDecoration(
          hintText: 'Никнейм игрока...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
