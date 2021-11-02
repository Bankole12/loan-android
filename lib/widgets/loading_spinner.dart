import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SpinKitHourGlass(
  color: Colors.blue,
  size: 50.0,
);
/*
    return Container(
      color: Colors.grey[300],
      width: 70,
      height: 70,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );*/
  }
}