import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/utils/constants.dart';

showAlertDialog({
  required String title,
  required String content,
  required BuildContext context,
  required Widget cancelActionWidget,
  required Widget defaultActionWidget,
  required void Function() defaultAction,
}) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor:
          AppCubit.get(context).isDark ? darkBackgroundColor : Colors.white,
      title: Text(
        title,
        style: TextStyle(
          color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
      ),
      actions: [
        InkWell(
          onTap: defaultAction,
          child: defaultActionWidget,
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: cancelActionWidget,
        ),
      ],
    ),
  );
}
