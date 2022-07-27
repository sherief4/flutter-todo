import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChooseColourWidget extends StatelessWidget {
  ChooseColourWidget({
    Key? key,
    required this.backgroundColor,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);
  final Color backgroundColor;
  final void Function() onTap;
  bool isSelected;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundColor: isSelected? Colors.grey.shade400 : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: CircleAvatar(
          radius: 16,
          backgroundColor: backgroundColor,
        ),
      ),
    );
  }
}
