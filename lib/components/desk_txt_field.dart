import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  const DescriptionTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      autocorrect: true,
      maxLength: 120,
      maxLines: 5,
      onEditingComplete: () {},
      onSubmitted: (value) {},
      decoration: InputDecoration(
          hintText: 'Описание игрока...',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6))),
    );
  }
}
