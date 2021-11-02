import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/formatters.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/services/mongo_service_helper.dart';
import 'package:pisto/widgets/app_bar_widget.dart';
import 'package:pisto/widgets/loading_page.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Loan extends StatefulWidget {
  @override
  _LoanState createState() => _LoanState();
}

class _LoanState extends State<Loan> {
  final LocalDatabaseHelper _db = LocalDatabaseHelper.instance;
  final TextStyle _lblStyle = TextStyle(
      color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold);
  final TextStyle _txtStyle = TextStyle(color: Colors.black, fontSize: 16.0);
  final TextStyle _loandetailTitleStyle = TextStyle(
      color: Colors.black, fontSize: 20.0, fontWeight: FontWeight.bold);
  final TextStyle _loandetailTxtStyle =
      TextStyle(color: Colors.black, fontSize: 18.0);
  final _statusColors = {
    'pending': Colors.yellow,
    'approved': Colors.green,
    'cancelled': Colors.red
  };
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isAdmin = false;

  List loans;

  Future<void> getLoans() async {
    UserLoginModel _user = await LocalDatabaseHelper.instance.getUser();

    List _loans = [];
    if (_user.role == 'admin' || _user.role == 'manager') {
      setState(() {
        _isAdmin = true;
      });
      _loans = await LoanService().getAllLoans();
    } else {
      _loans = await LocalDatabaseHelper.instance.getAllLoans();
    }
    setState(() {
      loans = _loans;
    });
  }

  showLoanDetail(ctxt, data) {
    return showDialog(
      context: ctxt,
      builder: (ctxt) {
        return Center(
          child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(ctxt).size.width * 0.9,
                // height: double.maxFinite,
                child: Column(
                  children: [
                    Container(
                      color: Colors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.only(left: 10.0),
                              child: Text(
                                'LOAN DETAILS',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              )),
                          Container(
                              child: IconButton(
                                  icon: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: MediaQuery.of(ctxt).size.height * 0.8,
                      child: ListView(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[400],
                                ),
                              )),
                              child: Text('Loan Information',
                                  style: _loandetailTitleStyle)),
                          SizedBox(height: 5),
                          Row(children: [
                            Text(
                              'Requested Amount:',
                              style: _loandetailTxtStyle,
                            ),
                            SizedBox(width: 10),
                            Text(
                              data['requestedamount'],
                              style: _loandetailTxtStyle,
                            )
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text(
                              'Interest:',
                              style: _loandetailTxtStyle,
                            ),
                            SizedBox(width: 10),
                            Text(
                              data['interestrate'],
                              style: _loandetailTxtStyle,
                            )
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Repay Amount:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['repayamount'],
                                style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Repay Date:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['repaydate'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          if (data['promocode'] != '')
                            Row(children: [
                              Text('Promocode:', style: _loandetailTxtStyle),
                              SizedBox(width: 10),
                              Text(data['promocode'],
                                  style: _loandetailTxtStyle)
                            ]),
                          if (data['promocode'] != '') SizedBox(height: 2),
                          SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[400],
                                ),
                              )),
                              child: Text('Personal Information',
                                  style: _loandetailTitleStyle)),
                          SizedBox(height: 5),
                          Row(children: [
                            Text('Name:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['firstname'] + ' ' + data['lastname'],
                                style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Email:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['email'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Phone:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['phone'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('ID Number:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['idnumber'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Gender:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['gender'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Date Of Birth:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(
                                formatDateTime(
                                    DateTime.parse(data['dateofbirth'])),
                                style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[400],
                                ),
                              )),
                              child: Text('Address Information',
                                  style: _loandetailTitleStyle)),
                          SizedBox(height: 5),
                          Row(children: [
                            Text('Region:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['region'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('City:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['city'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Street:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['street'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('House Number:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['houseaddress'],
                                style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 20),
                          Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  width: 2.0,
                                  color: Colors.grey[400],
                                ),
                              )),
                              child: Text('Identity Card Information',
                                  style: _loandetailTitleStyle)),
                          SizedBox(height: 5),
                          Column(children: [
                            Text('ID Front', style: _loandetailTxtStyle),
                            SizedBox(height: 2),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Image.memory(
                                    base64Decode(data['idfront']))),
                          ]),
                          SizedBox(height: 2),
                          Column(children: [
                            Text('ID Back', style: _loandetailTxtStyle),
                            SizedBox(height: 2),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child:
                                    Image.memory(base64Decode(data['idback']))),
                          ]),
                          SizedBox(height: 2),
                          Column(children: [
                            Text('ID Selfie', style: _loandetailTxtStyle),
                            SizedBox(height: 2),
                            Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Image.memory(
                                    base64Decode(data['idselfie']))),
                          ]),
                          if(_isAdmin)Container(
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        width: 2.0,
                                        color: Colors.grey[400],
                                      ),
                                    )),
                                    child: Text('Admin Action Required',
                                        style: _loandetailTitleStyle)),
                                SizedBox(height: 5),
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Text('Laon Status'),
                                      // SizedBox(height: 2),
                                      Container(
                                        width: 200,
                                        height: 60,
                                        child: FormBuilder(
                                          key: _formKey,
                                          // autovalidateMode: true,
                                          child: FormBuilderDropdown(
                                            name: 'status',
                                            decoration: InputDecoration(
                                              labelText: 'Loan Status',
                                            ),
                                            initialValue: '${data['status']}',
                                            // allowClear: true,
                                            // hint: Text('Select Gender'),
                                            validator:
                                                FormBuilderValidators.compose([
                                              FormBuilderValidators.required(
                                                  context)
                                            ]),
                                            items: [
                                              'pending',
                                              'approved',
                                              'cancelled'
                                            ]
                                                .map((ls) => DropdownMenuItem(
                                                      value: ls,
                                                      child: Text('$ls'),
                                                    ))
                                                .toList(),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        child: OutlineButton(
                                          onPressed: () async {
                                            // print(data['userId']);
                                            _formKey.currentState.save();
                                            if (_formKey.currentState
                                                .validate()) {
                                              Map<String, dynamic> _loanData = {
                                                'userId': data['userId'],
                                                'loanId': data['id'],
                                                'status': _formKey.currentState
                                                    .value['status']
                                              };
                                              int res = await LoanService()
                                                  .updateLoanStatus(_loanData);
                                              if (res == 1) {
                                                Navigator.pop(ctxt);
                                              }
                                            }
                                          },
                                          child: Text('Update'),
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Colors.black,
                                              width: 1),
                                        ),
                                      )
                                    ]),
                              ],
                            ),
                          ),
                          SizedBox(height: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    getLoans();
  }

  @override
  Widget build(BuildContext context) {
    // print('loan: ' + loans.toString());
    return Scaffold(
      appBar: MyAppBar(),
      drawer: MainDrawer(),
      body: Container(
        child: (loans == null || loans.isEmpty)
            ? (_isAdmin)
                ? LoadingPage()
                : Center(
                    child: Container(
                        child: Text(
                    'You have not requested for any loan',
                    style: _txtStyle,
                  )))
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: loans.length,
                      itemBuilder: (context, index) {
                        print(loans[index]);
                        return Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          // height: 180,
                          width: double.maxFinite,
                          child: Card(
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(
                                        width: 2.0,
                                        color: _statusColors[loans[index]
                                            ['status']]),
                                  ),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.all(7),
                                child: Column(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                'Name:',
                                                style: _lblStyle,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              child: Text(
                                                '${loans[index]['firstname'] + ' ' + loans[index]['lastname']}',
                                                style: _txtStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                'Requested Amount:',
                                                style: _lblStyle,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              child: Text(
                                                'GH ${loans[index]['requestedamount']}',
                                                style: _txtStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                'Interest:',
                                                style: _lblStyle,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              child: Text(
                                                'GH ${loans[index]['interestrate']}',
                                                style: _txtStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              child: Text(
                                                'Amount To Repay:',
                                                style: _lblStyle,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              child: Text(
                                                'GH ${loans[index]['repayamount']}',
                                                style: _txtStyle,
                                              ),
                                            )
                                          ],
                                        ),
                                        if (loans[index]['status'] == 'pending')
                                          Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  'Repayment Due Date:',
                                                  style: _lblStyle,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Container(
                                                child: Text(
                                                  '${loans[index]['repaydate']}',
                                                  style: _txtStyle,
                                                ),
                                              )
                                            ],
                                          ),
                                      ],
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 25.0,
                                      margin: EdgeInsets.only(top: 15),
                                      child: OutlineButton(
                                        onPressed: () {
                                          //TODO: show loan detail modal
                                          showLoanDetail(context, loans[index]);
                                        },
                                        child: Text('More'),
                                        borderSide: BorderSide(
                                            style: BorderStyle.solid,
                                            color: Colors.grey[350],
                                            width: 1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
