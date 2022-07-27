abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeTabBarState extends AppStates {}

class SelectDateState extends AppStates {}

class SelectStartTimeState extends AppStates {}

class SelectEndTimeState extends AppStates {}

class ChangeColorIndexState extends AppStates {}

class CreateDataBaseSuccessState extends AppStates {}

class CreateDataBaseLoadingState extends AppStates {}

class CreateDataBaseErrorState extends AppStates {
  CreateDataBaseErrorState({required this.error});

  final String error;
}

class GetTasksFromDatabaseLoadingState extends AppStates {}

class GetTasksFromDatabaseSuccessState extends AppStates {}

class GetTasksFromDatabaseErrorState extends AppStates {
  GetTasksFromDatabaseErrorState({required this.error});

  final String error;
}

class InsertDataToDatabaseLoadingState extends AppStates {}

class InsertDataToDatabaseSuccessState extends AppStates {}

class InsertDataToDatabaseErrorState extends AppStates {
  InsertDataToDatabaseErrorState({required this.error});

  final String error;
}

class DeleteTaskSuccessState extends AppStates {}

class FavouriteChangeState extends AppStates {}

class CompletedChangeState extends AppStates {}

class TasksFilteredSuccessState extends AppStates {}

class ListSortedState extends AppStates {}

class ChangeAppModeState extends AppStates {}

class ChooseReminderState extends AppStates {}
class SetNotificationScheduleSuccessState extends AppStates {}
class SetNotificationScheduleErrorState extends AppStates{
  SetNotificationScheduleErrorState({required this.error});
  final String error;
}