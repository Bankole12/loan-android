import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/formatters.dart';
import 'package:pisto/widgets/app_bar_widget.dart';
import 'package:pisto/widgets/loading_page.dart';
import 'package:pisto/services/mongo_service_helper.dart';
import 'package:pisto/widgets/loading_spinner.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  bool isUserLoading = true;
  String _notice = '';
  bool _isVisible = false;
  bool _isLoading = false;

  final TextStyle _loandetailTxtStyle =
      TextStyle(color: Colors.black, fontSize: 18.0);

  List users = [];

  Map<String, dynamic> res = {};
  Future<void> dashData() async {
    // LocalDatabaseHelper dbh = LocalDatabaseHelper.instance;
    Map<String, dynamic> _res = await DashBoardService().getDashData();
    setState(() {
      res = _res;
      users = _res['userslist'];
      isUserLoading = false;
    });
  }

  showUserDetail(ctxt, data) {
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
                // margin: EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(ctxt).size.width * 0.9,
                height: 380,
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
                                'USER DETAILS',
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
                      height: 2,
                    ),
                    Container(
                      // height: MediaQuery.of(ctxt).size.height * 0.8,
                      child: Column(
                        children: [
                          Container(
                              height: 180,
                              width: MediaQuery.of(ctxt).size.width,
                              child: (data['picture'] == '')
                                  ? MaterialButton(
                                      onPressed: () {},
                                      color: Colors.grey,
                                      textColor: Colors.white,
                                      child: Icon(
                                        Icons.person,
                                        size: 150.0,
                                      ),
                                    )
                                  : Image.memory(
                                      base64Decode(data['picture']))),
                          SizedBox(height: 5),
                          Row(children: [
                            Text(
                              'Name',
                              style: _loandetailTxtStyle,
                            ),
                            SizedBox(width: 10),
                            Text(
                              data['name'],
                              style: _loandetailTxtStyle,
                            )
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text(
                              'Email:',
                              style: _loandetailTxtStyle,
                            ),
                            SizedBox(width: 10),
                            Text(
                              data['email'],
                              style: _loandetailTxtStyle,
                            )
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Is Logged In? :', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(data['islogin'], style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Last Login Date:',
                                style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(formatDateTime(data['logindate']),
                                style: _loandetailTxtStyle)
                          ]),
                          SizedBox(height: 2),
                          Row(children: [
                            Text('Created Date:', style: _loandetailTxtStyle),
                            SizedBox(width: 10),
                            Text(formatDateTime(DateTime.parse(data['stamp'])),
                                style: _loandetailTxtStyle)
                          ]),
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

  showAddUser(context) {
    final String validName = r"^[a-zA-Z']+$";
    final _formKey = GlobalKey<FormBuilderState>();
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
              type: MaterialType.transparency,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                padding: EdgeInsets.all(15),
                // margin: EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width * 0.9,
                height: 560,
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
                                'ADD USER',
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
                    if (_isVisible)
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 10.0),
                        child: Text('$_notice',
                            style:
                                TextStyle(color: Colors.red, fontSize: 16.0)),
                      ),
                    if (_isLoading) Container(
                      margin: EdgeInsets.only(top: 5),
                      child:LoadingSpinner()
                    ),
                    Container(
                      child: FormBuilder(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.always,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                              child: FormBuilderTextField(
                                name: 'firstname',
                                decoration: const InputDecoration(
                                    labelText: 'First Name *'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.match(
                                      context, validName,
                                      errorText: 'Invalid Name.'),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child: FormBuilderTextField(
                                name: 'lastname',
                                decoration: const InputDecoration(
                                    labelText: 'Last Name *'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.match(
                                      context, validName,
                                      errorText: 'Invalid Name.'),
                                ]),
                                keyboardType: TextInputType.text,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child: FormBuilderTextField(
                                name: 'email',
                                decoration: const InputDecoration(
                                    labelText: 'Email Address*'),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.required(context),
                                  FormBuilderValidators.email(context,
                                      errorText: 'Invalid email address.')
                                ]),
                                keyboardType: TextInputType.emailAddress,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child: FormBuilderTextField(
                                name: 'password',
                                decoration: const InputDecoration(
                                    labelText: 'Password *'),
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                keyboardType: TextInputType.text,
                                obscureText: true
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 0.0),
                              child: FormBuilderDropdown(
                                name: 'role',
                                decoration: InputDecoration(
                                  labelText: 'User Role',
                                ),
                                initialValue: 'standard',
                                validator: FormBuilderValidators.compose(
                                    [FormBuilderValidators.required(context)]),
                                items: ['standard', 'admin', 'manager']
                                    .map((role) => DropdownMenuItem(
                                          value: role,
                                          child: Text('$role'),
                                        ))
                                    .toList(),
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              width: 200.0,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _formKey.currentState.save();
                                  if (_formKey.currentState.validate()) {
                                    setState(() {
                                      _isLoading = true;
                                      _isVisible = false;
                                     
                                    });

                                    Map<String, dynamic> res =
                                        await AuthService().signup(
                                            _formKey.currentState.value);
                                    if (res.containsKey('success')) {
                                      setState(() {
                                        _isLoading = false;
                                      });
                                      Navigator.pop(context);
                                    } else {
                                      setState(() {
                                        _isLoading = false;
                                        _isVisible = true;
                                        _notice = res['error'];
                                      });
                                    }
                                  }
                                },
                                child: Text('Add'),
                              ),
                            ),
                          ],
                        ),
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
    dashData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print('usersList: ' + users.toString());

    // final signupForm = ;

    final _usersPage = Center(
        child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: users.length,
              itemBuilder: (context, index) {
                // print(users[index]);
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  // height: 180,
                  width: double.maxFinite,
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                      // height: 65.0,
                      color: Colors.purple[50],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MaterialButton(
                            onPressed: () {},
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Icon(
                              Icons.person,
                              size: 34.0,
                            ),
                            padding: EdgeInsets.all(6.0),
                            shape: CircleBorder(),
                          ),
                          Container(
                            // margin: EdgeInsets.only(top: 6),
                            // width: 130.0,
                            child: Text(
                              '${users[index]['name']}',
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                          ),
                          // SizedBox(
                          //   width: 5.0,
                          // ),
                          Container(
                            // width: 50,
                            padding: EdgeInsets.only(bottom: 5),
                            child: OutlineButton(
                              onPressed: () {
                                //TODO: show loan detail modal
                                showUserDetail(context, users[index]);
                              },
                              child: Text(
                                '...',
                                style: TextStyle(fontSize: 18.0),
                                textAlign: TextAlign.center,
                              ),
                              borderSide: BorderSide(
                                style: BorderStyle.none,
                                // color: Colors.grey[350],
                                // width: 1
                              ),
                            ),
                          )
                          // Text(
                          //   '...',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 18.0,
                          //   ),
                          //   textAlign: TextAlign.end,
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));

    final _floatingButton = FloatingActionButton(
      onPressed: () {
        showAddUser(context);
      },
      child: Icon(
        Icons.add,
        size: 34,
      ),
      backgroundColor: Colors.blue,
    );

    return Scaffold(
      appBar: MyAppBar(),
      drawer: MainDrawer(),
      body: (isUserLoading) ? LoadingPage() : _usersPage,
      floatingActionButton: (!isUserLoading) ? _floatingButton : null,
    );
  }
}
