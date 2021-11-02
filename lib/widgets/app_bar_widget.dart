import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget{
  @override
  Size get preferredSize => const Size.fromHeight(60);
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          actions: [
            Container(
              width: 120.0,
              height: 10.0,
              margin: EdgeInsets.fromLTRB(0.0, 12.0, 5.0, 12.0),
              child: OutlineButton(
                onPressed: () {},
                child: Text('Client Zone'),
                borderSide: BorderSide(
                    style: BorderStyle.solid, color: Colors.black, width: 1),
              ),
            ),
          ],
      );
  }
}