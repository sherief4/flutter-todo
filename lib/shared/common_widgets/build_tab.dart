import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/shared/common_widgets/show_alert_dialog.dart';
import 'package:todo_app/shared/common_widgets/task_widget.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/utils/constants.dart';

class BuildTab extends StatelessWidget {
  const BuildTab({Key? key, required this.notes}) : super(key: key);
  final List<Map> notes;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is DeleteTaskSuccessState) {
          showSnackBar(context, 'Task is deleted successfully');
        }
      },
      builder: (context, state) {
        if (notes.isNotEmpty) {
          return ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return BuildTaskWidget(
                title: notes[index]['title'],
                color: Color(
                  notes[index]['color'],
                ),
                favouritePressed: () {
                  AppCubit.get(context).changeFavourite(
                    id: notes[index]['id'],
                    status: notes[index]['favourite'],
                  );
                },
                changeCompleted: () {
                  AppCubit.get(context).changeCompleted(
                    id: notes[index]['id'],
                    status: notes[index]['completed'],
                  );
                },
                isFavourite: notes[index]['favourite'] == 1,
                deletePressed: () {
                  showAlertDialog(
                    title: 'Are you sure?',
                    content: 'Sure you wanna delete this task',
                    context: context,
                    cancelActionWidget: Container(
                      width: 90.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.red,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
                            ),
                            Text(
                              'Cancel',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                    ),
                    defaultActionWidget: Container(
                      width: 90.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.green,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Icon(
                              Icons.delete_forever,
                              color: Colors.green,
                            ),
                            Text(
                              'Delete',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    defaultAction: () {
                      AppCubit.get(context).deleteTask(id: notes[index]['id']);
                      Navigator.of(context).pop();
                    },
                  );
                },
                isCompleted: notes[index]['completed'] == 1,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16.0,
              );
            },
            itemCount: notes.length,
          );
        } else {
          return Center(
            child: Text(
              'There is no tasks to show',
              style: TextStyle(
                color: AppCubit.get(context).isDark
                    ? Colors.grey.shade400
                    : Colors.black,
                letterSpacing: 1.2,
              ),
            ),
          );
        }
      },
    );
  }
}
