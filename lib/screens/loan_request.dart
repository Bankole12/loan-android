import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:objectid/objectid.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pisto/main.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/widgets/app_bar_widget.dart';


class LoanRequest extends StatefulWidget {
  @override
  _LoanRequestState createState() => _LoanRequestState();
}

class _LoanRequestState extends State<LoanRequest> {
  final String _repaymentDays = 'repaymentdays';
  final String _interestRate = 'interestrate';
  final String _reqAmt = 'requestedamount';
  final String _repAmt = 'repayamount';
  final String _repDate = 'repaydate';
  final String _promo = 'promocode';
  // String _userId = '';
  // double _currentAmountValue = 30;
  // double _currentDaysValue = 22;
  // String _days = '22';
  // double _interestRate = 12;

static const locale = "en";

DateFormat newFormat;
var _now = new DateTime.now();

  
  
  // var newFormat = DateFormat.yMMMEd('en');
  // Map<String, dynamic> user = {};
  Map<String, dynamic> loanData = {};
  LocalDatabaseHelper db = LocalDatabaseHelper.instance;
  UserLoginModel user;

  BoxDecoration bxstyle = BoxDecoration(
      gradient: LinearGradient(
    colors: [
      Color(0xff360167),
      Color(0xff6B0772),
      Color(0xffCF268A),
      Color(0xffE65C9C),
      Color(0xffFB8CAB),
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  ));

  Future<void> chechLoginState() async {
    UserLoginModel _user = await db.getUser();
    setState(() {
      user = _user;
    });
  }

  Future<void> callLocale() async {
    await initializeDateFormatting(locale).then((_) {
      newFormat = DateFormat.yMMMEd();
      loanData[_repDate] = newFormat.format(_now.add(Duration(days: 22)));
    });
  }

  @override
  void initState() {
    super.initState();
    
    loanData = {
      _reqAmt: 30.0,
      _repaymentDays: '22',
      _interestRate: 12.0,
      _repAmt: 0,
      _repDate: 22,
      _promo: '',
    };
    loanData[_repAmt] = loanData[_reqAmt] + loanData[_interestRate];
    callLocale();
    chechLoginState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> _arguments = ModalRoute.of(context).settings.arguments;
    print("loan_reuest_init: " + _arguments.toString());
    if (_arguments != null && _arguments['lrs'] == 'success') {
      //TODO:make a call to server and update local db
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: (user != null) ? MyAppBar() : null,
      drawer: (user != null) ? MainDrawer() : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Ink(
              decoration: bxstyle,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text(
                        'Loan for any purpose in 24 hours        ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      Text(
                        'Request a loan from GH30 to GH140 without visiting the office.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.0),
                      ),
                      Text(
                        'Payment in 2 hours at your favourite Bank.',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            letterSpacing: 1.0),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        'Amount above GH40 are vailable only to regular customers. Pay loans on time to improve your credit history',
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 14.0,
                            letterSpacing: 1.0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How much do you need?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                  Text(
                    'GH${loanData[_reqAmt]}',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                child: Slider(
                  value: loanData[_reqAmt],
                  min: 30,
                  max: 140,
                  divisions: 22,
                  label: loanData[_reqAmt].round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      loanData[_reqAmt] = value;
                      loanData[_repAmt] = value + loanData[_interestRate];
                    });
                  },
                )),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'When are you ready to repay?',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  ),
                  Text(
                    '${loanData[_repaymentDays]} days',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 12.0),
                child: Slider(
                  value: double.parse(loanData[_repaymentDays]),
                  min: 22,
                  max: 45,
                  divisions: 23,
                  label: loanData[_repaymentDays],
                  onChanged: (double value) {
                    setState(() {
                      loanData[_repaymentDays] = value.round().toString();
                      loanData[_repDate] = newFormat.format(_now.add(
                          Duration(days: int.parse(value.round().toString()))));
                    });
                  },
                )),
            Container(
                height: 70.0,
                padding: const EdgeInsets.symmetric(
                    horizontal: 23.0, vertical: 12.0),
                child: RaisedButton(
                  onPressed: () async {
                    if (user == null) {
                      print('User not logged in');
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Notice'),
                            content: Text('Log in to access loan'),
                            actions: [
                              FlatButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              FlatButton(
                                child: Text("Ok"),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(
                                      context, LoginRoute);
                                },
                              )
                            ],
                          );
                        },
                      );
                    } else {
                      print('User is logged in');
                      print("loan: " + loanData.toString());
                      LoanRequestModel loan = LoanRequestModel();
                      final id = ObjectId();
                      loan.id = id.hexString;
                      loan.requestedamount = loanData[_reqAmt].toString();
                      loan.interestrate = loanData[_interestRate].toString();
                      loan.repaymentdays = loanData[_repaymentDays];
                      loan.repaydate = loanData[_repDate];
                      loan.repayamount = loanData[_repAmt].toString();
                      loan.promocode = "";

                      LoanRequestModel loanRequestModel = await db.getLoanRequest();
                      int res;
                      (loanRequestModel != null && loanRequestModel.id != null)
                          ? res = await db.updateLoanRequest(loan)
                          : res = await db.insertLoanRequest(loan);

                      if (res == 1) {
                        Navigator.pushNamed(context, PersonalInformationRoute);
                      }
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0)),
                  padding: EdgeInsets.all(0.0),
                  child: Ink(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xff360167),
                            Color(0xff6B0772),
                            Color(0xffCF268A),
                            Color(0xffE65C9C),
                            Color(0xffFB8CAB),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                        borderRadius: BorderRadius.circular(7.0)),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      alignment: Alignment.center,
                      child: Text(
                        "Get Loan",
                        style: TextStyle(color: Colors.white70, fontSize: 18.0),
                      ),
                    ),
                  ),
                )),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'You get',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    "GH${loanData[_reqAmt]}",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Interest Rate',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    'GH${loanData[_interestRate]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Amount to Return',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    'GH${loanData[_repAmt]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Return Date',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    '${loanData[_repDate]}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black),
                  )
                ],
              ),
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
              child: Row(
                children: [
                  Expanded(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                    'Promocode',
                    style: TextStyle(fontSize: 18.0, color: Color(0xff360167)),
                  ),
                  Container(
                      height: 25.0,
                      width: 125,
                      child: TextField(
                        obscureText: false,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left:3.0),
                            hintText: 'PROMOCODE',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onChanged: (text) {},
                      )),
                  Container(
                    height: 25.0,
                    width: 70,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text(
                        'Apply',
                        style: TextStyle(color: Colors.black54),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          style: BorderStyle.solid,
                          color: Color(0xffE65C9C),
                          width: 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      )
                     
                    ),
                  )

                    ],
                    )
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
