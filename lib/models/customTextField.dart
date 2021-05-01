import 'package:flutter/material.dart';

Widget customTextField (
      {
        @required String label ,
        Function onChange ,
        @required Function validatFunction ,
        @required TextEditingController textController ,
        @required IconData prefixIcon ,
        Function onTap,
        bool isClickable = true
      })
       =>  Padding(
       padding: const EdgeInsets.symmetric(horizontal: 5),
       child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(prefixIcon , color : Colors.grey),
                  contentPadding: EdgeInsets.symmetric(vertical: 8 , horizontal: 5),
                  hintText:label,
                  hintStyle: TextStyle(
                      color:  Colors.grey,
                      fontSize: 16),
                  focusedBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Color(0xFFE2B6AA))),
                  border: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: new OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.grey))),
              controller: textController,
              onChanged:  onChange ,
              validator:  validatFunction ,
              onTap: onTap,
              enabled: isClickable,
            ),
          ),
        ],
      ),
    );



