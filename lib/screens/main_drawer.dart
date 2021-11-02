import 'package:flutter/material.dart';
import 'package:pisto/main.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/services/mongo_service_helper.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  LocalDatabaseHelper db = LocalDatabaseHelper.instance;
  UserLoginModel user;
  bool isAdmin = false;
  Future<void> fetchUser() async {
    UserLoginModel _user = await db.getUser();
    setState(() {
      user = _user;
      if (_user.role == 'admin' || _user.role == 'manager') {
        isAdmin = true;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUser();
  }

  @override
  Widget build(BuildContext ctxt) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: <Color>[Colors.lightBlue, Colors.blue])),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 90.0,
                      height: 90.0,
                      margin: EdgeInsets.only(bottom: 10.0),
                      child: Material(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        elevation: 10,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          // child: Icon(Icons.person,size: 60.0,),
                          child: (user != null && user.picture != '')
                              ? Image.network(user.picture)
                              : Icon(
                                  Icons.person,
                                  size: 60.0,
                                ),
                        ),
                      ),
                    ),
                    Text(
                      '${(user != null) ? user.name : ''}',
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                    )
                  ],
                ),
              )),
          CustomListTile(
              Icons.home,
              'Home',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.pushNamed(ctxt, LandingRoute)
                  }),
          if (isAdmin) CustomListTile(
              Icons.dashboard,
              'Dashboard',
              () => {
                    Navigator.pop(ctxt),
                    Navigator.pushNamed(ctxt, DashboardRoute)
                  }),
          if (isAdmin)
            CustomListTile(
                Icons.people,
                'Users',
                () => {
                      Navigator.pop(ctxt),
                      Navigator.pushNamed(ctxt, UsersRoute)
                    }),
          CustomListTile(
              Icons.money,
              'Loans',
              () =>
                  {Navigator.pop(ctxt), Navigator.pushNamed(ctxt, LoanRoute)}),
          CustomListTile(Icons.person, 'Profile', () => {Navigator.pop(ctxt)}),
          CustomListTile(
              Icons.settings, 'Settings', () => {Navigator.pop(ctxt)}),
          CustomListTile(Icons.lock, 'Log Out', () async {
            int res = await AuthService().logout(user.email, user.id);
            if (res == 1) {
              Navigator.pop(ctxt);
              Navigator.pushNamed(ctxt, LandingRoute);
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content:
                        Text('Could not logged you out. Please try again.'),
                    actions: [
                      // FlatButton(
                      //   child: Text("Cancel"),
                      //   onPressed: () {
                      //     Navigator.of(context).pop();
                      //   },
                      // ),
                      FlatButton(
                        child: Text("OK"),
                        onPressed: () {
                          Navigator.of(context).pop();
                          // Navigator.pushReplacementNamed(
                          //     context, LoginRoute);
                        },
                      )
                    ],
                  );
                },
              );
            }
          }),
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                        ),
                        Text(
                          text,
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_right)
                  ],
                ))),
      ),
    );
  }
}
