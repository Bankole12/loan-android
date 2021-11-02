import 'package:flutter/material.dart';
import 'package:pisto/widgets/loading_spinner.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            LoadingSpinner(),
            SizedBox(height: 20.0,),
            Text(
              'Loading please wait ...',
              style: TextStyle(
                fontSize: 24.0
              ),
            ),
          ]
        ),
      ) 
    );
  }
}