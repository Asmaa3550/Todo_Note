import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_demo/bloc/cubit.dart';
import 'package:todo_demo/bloc/stats.dart';
import 'package:todo_demo/models/customTextField.dart';

import 'package:conditional/conditional.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeLayOut extends StatelessWidget {
  String taskTitle;

  var textController = TextEditingController();
  var timeController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TasksCubit()..createDatabase(),
      child: BlocConsumer<TasksCubit, CubitStates>(
        listener: (context, state) {
          if (state is AddState) print('Initial State');
          if (state is DeleteState) print('Initial State');
          if (state is UpdateState) print('Initial State');
          if (state is GetState) print('Initial State');
        },
        builder: (context, state) {
          TasksCubit cubit = TasksCubit.get(context);
          return SafeArea(
              child: Container(
                decoration: BoxDecoration(
                  image : DecorationImage(
                    image : AssetImage(
                      'assets/images/bbb0089579d83a8c6b207795ec135cf8.jpg'
                    ),
                    fit: BoxFit.fill
                  )
                ),
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  extendBody: true,
                    key: scaffoldKey,
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      title: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric( horizontal: 10.0),
                            child: Icon(
                                Icons.notes_outlined,
                                color: Colors.black,
                                size : 25.0
                            ),
                          ),
                          Text(
                            'TODO NOTES',
                            style: TextStyle(color: Colors.black , fontSize: 30.0 , fontFamily: 'UbuntuMono-Regular'),
                          ),
                        ],
                      ),
                      elevation: 0,
                    ),
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: Color(0xFFE2B6AA),
                      child: Icon(
                          cubit.bottomSheetStatus ? Icons.add : Icons.edit,
                          color: Colors.white),
                      onPressed: () async {
                        if (cubit.bottomSheetStatus) {
                          if (formKey.currentState.validate()) {
                            cubit.addToDatabase(textController.text,
                                dateController.text, timeController.text, 'New');
                            Navigator.pop(context);
                          }
                          textController.clear();
                          timeController.clear();
                          dateController.clear();

                        } else {
                          scaffoldKey.currentState
                              .showBottomSheet(
                                (context) => Form(
                                  key: formKey,
                                  child: Material(
                                    elevation: 20.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            customTextField(
                                              label: 'Task Text',
                                              prefixIcon: Icons.title,
                                              textController: textController,
                                              validatFunction: (String value) {
                                                if (value.isEmpty) {
                                                  return 'Text Must not be Empty ';
                                                }
                                              },
                                            ),
                                            customTextField(

                                                label: 'Task Time',
                                                prefixIcon:
                                                    Icons.watch_later_outlined,
                                                textController: timeController,
                                                // isClickable: false,
                                                validatFunction: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Select Time';
                                                  }
                                                },
                                                onTap: () {
                                                  showTimePicker(
                                                    context: context,
                                                    initialTime: TimeOfDay.now(),
                                                  ).then((value) => {
                                                        timeController.text =
                                                            value.format(context)
                                                      });
                                                }),
                                            customTextField(
                                                label: 'Task Date',
                                                prefixIcon: Icons.calendar_today,
                                                textController: dateController,
                                                // isClickable: false,
                                                validatFunction: (String value) {
                                                  if (value.isEmpty) {
                                                    return 'Select Date';
                                                  }
                                                },
                                                onTap: () {
                                                  showDatePicker(
                                                          context: context,
                                                          initialDate:
                                                              DateTime.now(),
                                                          firstDate:
                                                              DateTime.now(),
                                                          lastDate: DateTime.parse(
                                                              '${DateTime.now().year + 5}-0${DateTime.now().month}-${DateTime.now().day}'))
                                                      .then((value) => {
                                                            dateController.text =
                                                                '${value.year}/${value.month}/${value.day}',
                                                          });
                                                })
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .closed
                              .then((value) =>
                                  {cubit.toggelbottomSheetStatus(false)});
                          cubit.toggelbottomSheetStatus(true);
                        }
                      },
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      selectedLabelStyle: TextStyle(
                        // color : Color(0xFFE2B6AA) ,  fontSize: 30.0
                          color: Color(0xFFE2B6AA)
                      ),
                      selectedIconTheme: IconThemeData(
                        color: Color(0xFFE2B6AA) , size: 25.0
                      ),
                      onTap: (index) {
                        cubit.changeNavigationBarIndex(index);
                      },
                      currentIndex:
                          TasksCubit.get(context).currentNavigationIndex,
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(Icons.menu), label: 'New Tasks'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.done), label: 'Done'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.archive_outlined),
                            label: 'Archived'),
                      ],
                      elevation: 14.0,
                    ),
                    body:cubit.screens[cubit.currentNavigationIndex]),
              ));
        },
      ),
    );
  }
}
