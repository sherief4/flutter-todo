import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/common_widgets/build_task_tile.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/utils/constants.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                size: 20.0,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            title: const Text(
              'Schedule',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 4.0,
                  color: Colors.grey.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.all(
                    16.0,
                  ),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: myGreen,
                    selectedTextColor: Colors.white,
                    dateTextStyle: TextStyle(
                      color: cubit.isDark ? Colors.white : Colors.grey.shade400,
                    ),
                    dayTextStyle: TextStyle(
                      color: cubit.isDark ? Colors.white : Colors.grey.shade400,
                    ),
                    monthTextStyle: TextStyle(
                      color: cubit.isDark ? Colors.white : Colors.grey.shade400,
                    ),
                    deactivatedColor: AppCubit.get(context).isDark
                        ? Colors.white
                        : Colors.black,
                    onDateChange: (date) {
                      cubit.scheduleDay = DateFormat('EEEE').format(date);
                      cubit.scheduleDate =
                          DateFormat('d MMMM, yyy').format(date);
                      cubit.filterTasks(DateFormat('dd-MM-yyy').format(date));
                    },
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 4.0,
                  color: Colors.grey.shade200,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                    left: 16.0,
                    right: 16.0,
                    top: 8.0,
                  ),
                  child: Row(
                    children: [
                      Text(
                        cubit.scheduleDay,
                        style: TextStyle(
                          color: AppCubit.get(context).isDark
                              ? Colors.grey.shade400
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.0,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        cubit.scheduleDate,
                        style:  TextStyle(
                          color: AppCubit.get(context).isDark
                              ? Colors.grey.shade400
                              : Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
                if (AppCubit.get(context).filtered.isNotEmpty)
                  Expanded(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return BuildTaskTile(
                          color: cubit.filtered[index]['color'],
                          startTime: cubit.filtered[index]['start'],
                          title: cubit.filtered[index]['title'],
                          isCompleted: cubit.filtered[index]['completed'] == 1,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16.0,
                        );
                      },
                      itemCount: cubit.filtered.length,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
