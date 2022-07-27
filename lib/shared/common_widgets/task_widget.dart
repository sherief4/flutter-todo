import 'package:flutter/material.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/utils/constants.dart';

// ignore: must_be_immutable
class BuildTaskWidget extends StatelessWidget {
  BuildTaskWidget({
    Key? key,
    required this.isCompleted,
    required this.title,
    required this.color,
    required this.favouritePressed,
    required this.isFavourite,
    required this.deletePressed,
    required this.changeCompleted,
  }) : super(key: key);
  final String title;
  final Color color;
  bool isFavourite;
  final void Function() favouritePressed;
  final void Function() deletePressed;
  bool isCompleted;
  final void Function() changeCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: changeCompleted,
          child: Container(
            width: 30.0,
            height: 30.0,

            decoration: BoxDecoration(
              color: isCompleted ? color : AppCubit.get(context).isDark ? darkBackgroundColor : Colors.white,
              borderRadius: BorderRadius.circular(
                8.0,
              ),
              border: Border.all(
                width: 2.0,
                color: color,
              ),
            ),
            child:  Center(
              child: Icon(
                Icons.check,
                color: AppCubit.get(context).isDark ? darkBackgroundColor : Colors.white,
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Text(
            title,
            style:  TextStyle(
              color: AppCubit.get(context).isDark ? Colors.white : Colors.black,
              fontSize: 18.0,
              overflow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: favouritePressed,
          icon: isFavourite
              ? Icon(
                  Icons.favorite,
                  color: color,
                )
              : Icon(
                  Icons.favorite_border,
                  color: color,
                ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: deletePressed,
          icon: Icon(
            Icons.delete,
            color: myRed,
          ),
        ),
      ],
    );
  }
}
