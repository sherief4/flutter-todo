import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:sqflite/sqflite.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/main.dart';
import 'package:todo_app/shared/cubit/states.dart';
import 'package:todo_app/shared/utils/cache_helper.dart';
import 'package:todo_app/shared/utils/constants.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  int curIn = 0;

  void changeTabBar(int index) {
    curIn = index;
    emit(ChangeTabBarState());
  }

//Select date  and time methods
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedStartTime = TimeOfDay.now();
  TimeOfDay selectedEndTime = TimeOfDay.now();

  void selectDate(BuildContext context) async {
    emit(SelectDateState());
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null) {
      selectedDate = picked;
      emit(SelectDateState());
    }
  }

  void selectStartTime(BuildContext context) async {
    emit(SelectStartTimeState());
    final TimeOfDay? selected =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (selected != null) {
      selectedStartTime = selected;
      emit(SelectStartTimeState());
    }
  }

  void selectEndTime(BuildContext context) async {
    emit(SelectEndTimeState());
    final TimeOfDay? selected = await showTimePicker(
      context: context,
      initialTime: selectedEndTime,
    );
    if (selected != null) {
      selectedEndTime = selected;
      emit(SelectEndTimeState());
    }
  }

  //Select and change colors

  List<int> myColors = [
    0xffff5147,
    0xffff9d42,
    0xfff9c50b,
    0xff25c06d,
    0xff42a0ff,
  ];

  int colorIndex = 0;
  Color noteColor = myRed;

  void changeColorIndex(int index) {
    colorIndex = index;
    noteColor = Color(myColors[index]);
    emit(ChangeColorIndexState());
  }

  Duration selectedDuration = const Duration(
    days: 0,
    hours: 0,
    minutes: 0,
  );

  void chooseDuration(String value) {
    if (value == '1 day before') {
      selectedDuration = const Duration(days: 1, hours: 0, minutes: 0);
    }
    if (value == '1 hour before') {
      selectedDuration = const Duration(days: 0, hours: 1, minutes: 0);
    }
    if (value == '30 min before') {
      selectedDuration = const Duration(days: 0, hours: 0, minutes: 30);
    }
    if (value == '10 min before') {
      selectedDuration = const Duration(days: 1, hours: 0, minutes: 0);
    }
    debugPrint(selectedDuration.toString());
    emit(ChooseReminderState());
  }

  //Database functions

  late Database database;
  List<Map> allTasks = [];
  List<Map> favourites = [];
  List<Map> completed = [];
  List<Map> unCompleted = [];
  int id = 0;

  void createDatabase() async {
    await openDatabase('todo_app.db', version: 1,
        onCreate: (database, version) {
      debugPrint('Database created');
      database
          .execute(
              'CREATE TABLE Tasks ( id INTEGER PRIMARY KEY , title TEXT , date TEXT, start TEXT , end TEXT, favourite INTEGER, completed INTEGER, color INTEGER)')
          .then((value) {
        debugPrint('table  created');
      }).catchError((error) {
        emit(CreateDataBaseErrorState(error: error.toString()));
      });
    }, onOpen: (db) {
      getTasksFromDataBase(db);
    }).then((value) {
      database = value;
      emit(CreateDataBaseSuccessState());
    });
  }

  insertToDatabase({
    required String title,
    required String date,
    required String startTime,
    required String endTime,
    required int color,
  }) async {
    emit(InsertDataToDatabaseLoadingState());
    DateTime dt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      selectedEndTime.hour,
      selectedEndTime.minute,
    );
    final Duration dur = DateTime.parse(dt.toString())
            .difference(DateTime.parse(DateTime.now().toString())) -
        selectedDuration;

    return await database.transaction((txn) async {
      id++;
      await txn
          .rawInsert(
              'INSERT INTO Tasks (title, date, start, end, favourite, completed, color) VALUES ("$title", "$date", "$startTime", "$endTime", "${0}", "${0}","$color")')
          .then((value) {
        getTasksFromDataBase(database);

        scheduleNotification(id: id, title: title, duration: dur).then((value) {
          emit(InsertDataToDatabaseSuccessState());
        });
      }).catchError((error) {
        debugPrint(error.toString());
        emit(InsertDataToDatabaseErrorState(error: error.toString()));
      });
    });
  }

  Future<void> getTasksFromDataBase(Database database) async {
    emit(GetTasksFromDatabaseLoadingState());
    allTasks.clear();
    completed.clear();
    unCompleted.clear();
    favourites.clear();

    database.rawQuery('SELECT * From Tasks').then((value) {
      for (var element in value) {
        allTasks.add(element);

        if (element['completed'] == 1) {
          completed.add(element);
        }
        if (element['favourite'] == 1) {
          favourites.add(element);
        }
        if (element['completed'] == 0) {
          unCompleted.add(element);
        }
      }
      emit(GetTasksFromDatabaseSuccessState());

      sortLisT(allTasks);
      sortLisT(completed);
      sortLisT(favourites);
      sortLisT(unCompleted);
    }).catchError((error) {
      GetTasksFromDatabaseErrorState(error: error.toString());
    });
  }

  void deleteTask({required int id}) async {
    database.rawUpdate('DELETE FROM Tasks WHERE id = ?', [id]).then((value) {
      getTasksFromDataBase(database).then((value) {
        emit(DeleteTaskSuccessState());
      });
    });
  }

  void changeFavourite({required int id, required int status}) async {
    int val = status == 0 ? 1 : 0;
    database.rawUpdate('UPDATE Tasks SET favourite = ? WHERE id = ?',
        ['$val', id]).then((value) {
      getTasksFromDataBase(database).then((value) {
        emit(FavouriteChangeState());
      });
    });
  }

  void changeCompleted({required int id, required int status}) async {
    int val = status == 0 ? 1 : 0;
    database.rawUpdate('UPDATE Tasks SET completed = ? WHERE id = ?',
        ['$val', id]).then((value) {
      getTasksFromDataBase(database).then((value) {
        emit(FavouriteChangeState());
      });
    });
  }

  List<Map> filtered = [];
  String scheduleDate = '';
  String scheduleDay = '';

  Future<void> filterTasks(String date) async {
    filtered.clear();
    database
        .rawQuery('SELECT * FROM Tasks WHERE date = ?', [date]).then((value) {
      for (var data in value) {
        filtered.add(data);
      }
      emit(TasksFilteredSuccessState());
    });
  }

  void sortLisT(List<Map> list) {
    list.sort((a, b) {
      int compare = a['data'].compareTo(b['data']);
      if (compare == 0) {
        var c = a['startTime'];
        var d = b['startTime'];
        return c.compareTo(d);
      } else {
        return compare;
      }
    });
    emit(ListSortedState());
  }

  //theme method
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: 'isDark', value: isDark).then((value) {
        emit(ChangeAppModeState());
      });
    }
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required Duration duration,
  }) async {
    try {
      final String currentTimeZone =
          await FlutterNativeTimezone.getLocalTimezone();
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(currentTimeZone));
      await flutterLocalNotificationsPlugin.zonedSchedule(
          id,
          'Task Reminder',
          title,
          tz.TZDateTime.now(tz.local).add(duration),
          const NotificationDetails(
              android: AndroidNotificationDetails(
                  'your channel id', 'your channel name',
                  channelDescription: 'your channel description')),
          androidAllowWhileIdle: true,
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
      emit(SetNotificationScheduleSuccessState());
    } catch (e) {
      emit(SetNotificationScheduleErrorState(error: e.toString()));
    }
  }
}
