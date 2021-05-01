import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/bloc/stats.dart';
import 'package:todo_demo/modules/newTasks.dart';
import 'package:todo_demo/modules/archivedTaskes.dart';
import 'package:todo_demo/modules/doneTasks.dart';
import 'package:sqflite/sqflite.dart';

class TasksCubit extends Cubit<CubitStates> {

  TasksCubit() : super(InitialState()); // the state that bloc start from it .

  Database database;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];
  int tasksCount = 0 ;
  bool bottomSheetStatus = false;
  int currentNavigationIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  // object of the class ..
  static TasksCubit get(context) => BlocProvider.of<TasksCubit>(context);

  void changeNavigationBarIndex(int index){
    currentNavigationIndex = index ;
    emit(ChangeNavigationBar());
  }

  Future getDataFromDatabase (Database database) async {
    newTasks = await database.rawQuery('SELECT * FROM tasks WHERE status = "New"');
   doneTasks = await database.rawQuery('SELECT * FROM tasks WHERE status = "Done"');
   archivedTasks = await database.rawQuery('SELECT * FROM tasks WHERE status = "Archived"');
   tasksCount = newTasks.length + doneTasks.length + archivedTasks.length;
   print('Count is ' + tasksCount.toString());
   emit(GetState());
   print( 'new' + newTasks.toString());
   print('done' + doneTasks.toString());
   print('archived' + archivedTasks.toString());

  }

  void addToDatabase(@required text, @required date, @required time, status) async {
    await this.database.transaction((txn) {
        txn
            .rawInsert(
            'INSERT INTO tasks (title , date , time , status ) VALUES ( "${text.toString()}" , "$date", "$time" , "$status")')
            .then((value) => {
          print('$value inserted Successfully'),

        })
            .catchError((error) {
          print(error);
        });
        return null;
      });

    await getDataFromDatabase(this.database);
    // print('The Length Of Tasks List : ' + tasks.length.toString());
    // print('all Tasks Updated : ' + tasks.toString());
    emit(AddState());
  }

  void createDatabase () async {
    this.database = await openDatabase(
      'todo.db', // The Name Of Database File
      version: 1, // when create the database first time

      //  when create the database first time
      onCreate: (database, version)
      {
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )');
        print('Table Created');
        emit(CreateState());
      },
      // when open data created before
      onOpen: (database) async {
        await getDataFromDatabase(database);

        print('Table Opened');
        this.database = database;
      },);

    print('this database in the class : ' + this.database.toString());
  }

  void updateOnDatabase (int id  , String status) async {
     this.database.rawUpdate  (
        'UPDATE tasks SET status = ? WHERE id = ? ', [ '$status' , '$id']).then((value) async {
         emit(UpdateState());
     });
     await getDataFromDatabase(this.database);


  }
  void deleteFromDatabase (int id) async {
     database
        .rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) => print('the tasks after record deleted ' + value.toString()));

     await getDataFromDatabase(this.database);
     emit(DeleteState());
  }

  void toggelbottomSheetStatus (bool floatingActionStatus){
    bottomSheetStatus = floatingActionStatus;
    emit(ToggelFloatingButtom());
  }
}

