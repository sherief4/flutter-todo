import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/modules/add_task/add_task_screen.dart';
import 'package:todo_app/modules/schedule/schedule_screen.dart';
import 'package:todo_app/shared/common_widgets/build_tab.dart';
import 'package:todo_app/shared/utils/constants.dart';
import 'package:todo_app/shared/common_widgets/default_button.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';


class AppLayout extends StatelessWidget {
  const AppLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        List<Widget> tabs = [
          BuildTab(notes: cubit.allTasks),
          BuildTab(notes: cubit.completed),
          BuildTab(notes: cubit.unCompleted),
          BuildTab(notes: cubit.favourites),
        ];

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Board',
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.brightness_4_outlined,
                  color: AppCubit.get(context).isDark
                      ? Colors.white
                      : Colors.black,
                ),
                onPressed: () {
                  AppCubit.get(context).changeAppMode();
                },
              ),
              IconButton(
                onPressed: () {
                  cubit.scheduleDay = DateFormat('EEEE').format(DateTime.now());
                  cubit.scheduleDate =
                      DateFormat('d MMMM, yyy').format(DateTime.now());
                  cubit
                      .filterTasks(
                    DateFormat('dd-MM-yyy').format(
                      DateTime.now(),
                    ),
                  )
                      .then(
                    (value) {
                      navigateTo(context, const ScheduleScreen());
                    },
                  );
                },
                icon: const Icon(
                  Icons.calendar_month_rounded,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 4.0,
                  color: Colors.grey.shade200,
                ),
                DefaultTabController(
                  length: 4,
                  child: TabBar(
                    padding: EdgeInsets.zero,
                    isScrollable: true,
                    unselectedLabelColor: Colors.grey.shade400,
                    labelColor:
                        AppCubit.get(context).isDark ? myGreen : Colors.black,
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                    indicatorColor:
                        AppCubit.get(context).isDark ? myGreen : Colors.black,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                    onTap: (index) {
                      cubit.changeTabBar(index);
                    },
                    tabs: const [
                      Text(
                        'All',
                      ),
                      Text(
                        'Completed',
                      ),
                      Text(
                        'Uncompleted',
                      ),
                      Text(
                        'Favourites',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 16.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 4.0,
                    color: Colors.grey.shade200,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                    ),
                    child: tabs[cubit.curIn],
                  ),
                ),
              ],
            ),
          ),
          bottomSheet: Container(
            color: AppCubit.get(context).isDark
                ? darkBackgroundColor
                : Colors.white,
            child: DefaultButton(
              text: 'Add a task',
              backgroundColor: myGreen,
              onPressed: () {
                navigateTo(
                  context,
                  AddTaskScreen(),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
