import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/layout/cubit/states.dart';

import '../../modules/archive_task.dart';
import '../../modules/done_task.dart';
import '../../modules/new_task.dart';

class AppBlocCubit extends Cubit<AppStates>{
  AppBlocCubit() : super(InitialStates());
  static AppBlocCubit get(context) => BlocProvider.of(context);

int currentIndex=0;

  void bottomNavigationBarChange(int index) {
    currentIndex = index;
    emit(BottomNavigationBarChangeState());
  }
  List<Widget> screens = [
    NewTasksScreen(),
    ArchivedTasksScreen(),
    DoneTasksScreen(),
  ];
  List<String> titles = [
    'My Tasks',
    'done Tasks',
    'Archived Tasks',
  ];
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];

  late Database database;
  void createDatabase() {
    openDatabase(
        'todo.db', version: 1,
        onCreate: (database, version) {
          print('database created');
          database.execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            print('table created');
          }).catchError((error) {
            print('error when creating table ${error.toString()}');
          });
        }, onOpen: (database) {
      print(' database opened');
      getDataFromDatabase(database);
    }
    ).then((value) {
      database = value;
      emit(AppDatabaseCreatedState());
    });
  }
   insertToDatabase({
    required String title,
    required String date,
    required String time,
  })async {
    await database.transaction((txn) async {
      txn.rawInsert(
          'INSERT INTO tasks(title,date,time,status) VALUES("$title","$time","$date","new status")')
          .then((value) {
        print('$value is successful');
        emit(AppDatabaseInsertedState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('error when insert row${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newTasks=[];
    doneTasks=[];
    archiveTasks=[];
      database.rawQuery('SELECT * FROM tasks').then((value){
      value.forEach((element){
        if(element['status']=='new status'){
          newTasks.add(element);
        }else if(element['status']=='done'){
          doneTasks.add(element);
        }else {
          archiveTasks.add(element);
        }
      });
      emit(AppDatabaseGettingState());
    });
  }

  void updateDatabase ({
    required String status,
    required int id,
  }){
    database.rawUpdate(
        'UPDATE tasks SET status=? WHERE id = ?',
        [status, id]
    ).then((value){
      emit(AppDatabaseUpdatedState());
      getDataFromDatabase(database);
    });
  }
  void deleteDatabase({required int id}){
    database.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value){ // نفس النظام فى الابديت
      emit(AppDatabaseDeletedState());
      getDataFromDatabase(database);
    });

  }

}