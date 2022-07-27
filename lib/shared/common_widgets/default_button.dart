import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/utils/constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);
  final String text;
  final void Function() onPressed;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(
            10.0,
          ),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 2.0,
              color: AppCubit.get(context).isDark
                  ? darkBackgroundColor
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
