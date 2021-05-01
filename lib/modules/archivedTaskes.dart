import 'package:conditional/conditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_demo/bloc/cubit.dart';
import 'package:todo_demo/bloc/stats.dart';
import 'package:todo_demo/modules/taskItem.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, CubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        TasksCubit cubit = TasksCubit.get(context);
        return Conditional(
          condition: cubit.archivedTasks.length > 0,
          onConditionTrue: Container(
              padding: EdgeInsets.all(20.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return taskItem(
                        cubit.archivedTasks[index]['time'],
                        cubit.archivedTasks[index]['title'],
                        cubit.archivedTasks[index]['date'],
                        cubit.archivedTasks[index]['status'],
                        cubit.archivedTasks[index]['id'],
                        context);
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: cubit.archivedTasks.length)),
          onConditionFalse: Center(
              child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children : [
                    Image(
                      image : AssetImage('assets/images/Checklist.jpg'),
                    ),
                    Text('ADD NEW NOTES +' , style: TextStyle(color: Colors.black , fontSize: 24.0 , fontFamily: 'UbuntuMono-Regular' , fontWeight: FontWeight.w500))
                  ]
              )
          )
        );
      },
    );
    ;
  }
}
