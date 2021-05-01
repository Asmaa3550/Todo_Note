import 'package:flutter/material.dart';
import 'package:todo_demo/bloc/cubit.dart';
import 'dart:math';
import 'package:sk_alert_dialog/sk_alert_dialog.dart';
import 'package:todo_demo/shared/constants.dart';
import 'package:alert_dialog/alert_dialog.dart';
import 'package:flutter/cupertino.dart';

Widget taskItem(String time , String title , String date , String status  , id , context){
  Random random = new Random();
  int randomNumber = random.nextInt(10);
  return  Dismissible(
    key: Key('$id'),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 43.0,
            child : Text(
              time , style: TextStyle(
                color : Colors.white,
                fontFamily: 'ZenDots-Regular' ,
                fontSize: 12.0
            ),),
            backgroundColor: colors[randomNumber].withOpacity(0.5),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children :[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:5),
                      child: Text(title,
                          style: TextStyle(
                            color : Colors.black,
                            fontFamily: 'UbuntuMono-Regular' ,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600
                          )),
                    ),
                    SizedBox(height: 4.0),
                    Container(
                      // alignment: Alignment.centerLeft,
                      width : 100.0,
                      child: Divider(
                        color: Colors.black ,
                        thickness: 1,
                        indent: 5,
                        endIndent: 40,),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:5),
                      child: Text(date , style: TextStyle(
                          color : colors[randomNumber],
                          fontFamily: 'UbuntuMono-Regular' ,
                          fontSize: 16.0
                      )),
                    ),

                  ]
              ),
            ),
          ),
          IconButton(icon: Icon(
              Icons.check_box ,color: status == 'Done' ?  Colors.green : Colors.grey , size :25.0) ,
              onPressed: () async {
                // TasksCubit.get(context).updateOnDatabase(id, 'Done');
            // return  AlertDialog(
            //   title: Text('Confirmation' , overflow: TextOverflow.ellipsis,maxLines: 3,),
            //   content: Flexible(child: Text('Do You Want To Move This Task To Done Tasks ?')),
            //   actions: [
            //     TextButton(onPressed: (){}, child: Text('OK')),
            //     TextButton(onPressed: (){}, child: Text('Cancel')),
            //   ],
            // );
                return alert(context, title: Text('Alert') , );
          }),
          IconButton(icon: Icon(Icons.archive , color :  status == 'Archived' ?  Colors.redAccent : Colors.black54 , size :25.0) , onPressed: (){
            TasksCubit.get(context).updateOnDatabase(id, 'Archived');
          })
        ],
      ),
    ),
    onDismissed: (direction){
      TasksCubit.get(context).deleteFromDatabase(id);
    },
  );
}

