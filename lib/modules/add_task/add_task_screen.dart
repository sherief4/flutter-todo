import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/shared/common_widgets/choose_colour_widget.dart';
import 'package:todo_app/shared/common_widgets/default_button.dart';
import 'package:todo_app/shared/cubit/cubit.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/common_widgets/input_text_field.dart';
import 'package:todo_app/shared/utils/constants.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({Key? key}) : super(key: key);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {
        if (state is InsertDataToDatabaseSuccessState) {
          showSnackBar(context, 'Task created successfully');
          Navigator.of(context).pop();
        }
        if (state is SetNotificationScheduleErrorState) {
          showSnackBar(
            context,
            state.error,
          );
        }
      },
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        dateController.text =
            DateFormat('dd-MM-yyy').format(cubit.selectedDate);
        startTimeController.text =
            cubit.selectedStartTime.format(context).toString();
        endTimeController.text =
            cubit.selectedEndTime.format(context).toString();
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
              'Add task',
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics:const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 4.0,
                      color: cubit.noteColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        16.0,
                      ),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InputTextFormField(
                              controller: titleController,
                              title: 'Title',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Title can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              hintText: 'Enter task title',
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            InputTextFormField(
                              controller: dateController,
                              title: 'Date',
                              validate: (value) {
                                if (value!.isEmpty) {
                                  return 'Date can\'t be empty';
                                } else {
                                  return null;
                                }
                              },
                              suffixIcon: Icons.keyboard_arrow_down_outlined,
                              keyboardType: TextInputType.none,
                              suffixPressed: () {
                                cubit.selectDate(context);
                              },
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InputTextFormField(
                                    controller: startTimeController,
                                    title: 'Start time',
                                    validate: (value) {
                                      if (value!.isEmpty ||
                                          ((cubit.selectedEndTime.hour * 60 +
                                                      cubit.selectedEndTime
                                                          .minute) -
                                                  (cubit.selectedStartTime
                                                              .hour *
                                                          60 +
                                                      cubit.selectedStartTime
                                                          .minute)) <
                                              0) {
                                        return 'Invalid start time';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.none,
                                    suffixIcon: Icons.access_time_outlined,
                                    suffixPressed: () {
                                      cubit.selectStartTime(context);
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 24.0,
                                ),
                                Expanded(
                                  child: InputTextFormField(
                                    controller: endTimeController,
                                    title: 'End time',
                                    validate: (value) {
                                      if (value!.isEmpty ||
                                          ((cubit.selectedEndTime.hour * 60 +
                                                      cubit.selectedEndTime
                                                          .minute) -
                                                  (cubit.selectedStartTime
                                                              .hour *
                                                          60 +
                                                      cubit.selectedStartTime
                                                          .minute)) <
                                              0) {
                                        return 'Invalid end time';
                                      } else {
                                        return null;
                                      }
                                    },
                                    keyboardType: TextInputType.none,
                                    suffixIcon: Icons.access_time_outlined,
                                    suffixPressed: () {
                                      cubit.selectEndTime(context);
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              'Reminder',
                              style: TextStyle(
                                color: AppCubit.get(context).isDark
                                    ? Colors.grey.shade400
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Container(
                              height: 60.0,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(
                                  10.0,
                                ),
                              ),
                              child: DropdownButtonFormField(
                                  borderRadius: BorderRadius.circular(
                                    10.0,
                                  ),
                                  hint: const Text(
                                    'Choose a reminder',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                  ),
                                  focusColor: Colors.grey.shade400,
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey.shade400,
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                        10.0,
                                      ),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                  items: [
                                    "None",
                                    "1 day before",
                                    "1 hour before",
                                    "30 min before",
                                    "10 min before"
                                  ]
                                      .map(
                                        (label) => DropdownMenuItem(
                                          value: label,
                                          child: Text(
                                            label,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (value) {
                                    // cubit.chooseDuration(value!);
                                  }),
                            ),
                            const SizedBox(
                              height: 24.0,
                            ),
                            Text(
                              'Choose a color',
                              style: TextStyle(
                                color: AppCubit.get(context).isDark
                                    ? Colors.grey.shade400
                                    : Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 18.0,
                              ),
                            ),
                            const SizedBox(
                              height: 16.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ChooseColourWidget(
                                  backgroundColor: myRed,
                                  onTap: () {
                                    cubit.changeColorIndex(0);
                                  },
                                  isSelected: cubit.colorIndex == 0,
                                ),
                                ChooseColourWidget(
                                  backgroundColor: myOrange,
                                  onTap: () {
                                    cubit.changeColorIndex(1);
                                  },
                                  isSelected: cubit.colorIndex == 1,
                                ),
                                ChooseColourWidget(
                                  backgroundColor: myYellow,
                                  onTap: () {
                                    cubit.changeColorIndex(2);
                                  },
                                  isSelected: cubit.colorIndex == 2,
                                ),
                                ChooseColourWidget(
                                  backgroundColor: myGreen,
                                  onTap: () {
                                    cubit.changeColorIndex(3);
                                  },
                                  isSelected: cubit.colorIndex == 3,
                                ),
                                ChooseColourWidget(
                                  backgroundColor: myBlue,
                                  onTap: () {
                                    cubit.changeColorIndex(4);
                                  },
                                  isSelected: cubit.colorIndex == 4,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 60.0,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomSheet: Container(
            color: AppCubit.get(context).isDark
                ? darkBackgroundColor
                : Colors.white,
            child: DefaultButton(
              text: 'Create a task',
              backgroundColor: cubit.noteColor,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                    title: titleController.text,
                    date: dateController.text,
                    startTime: startTimeController.text,
                    endTime: endTimeController.text,
                    color: cubit.myColors[cubit.colorIndex],
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }
}
