import 'package:flutter/material.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:pisto/screens/address_verification.dart';
import 'package:pisto/screens/dashboard.dart';
import 'package:pisto/screens/identity_verification.dart';
import 'package:pisto/screens/loans.dart';
import 'package:pisto/screens/personal_information.dart';
import 'package:pisto/screens/loan_request.dart';
import 'package:pisto/screens/login.dart';
import 'package:pisto/screens/signup.dart';
import 'package:pisto/screens/users.dart';

const LandingRoute = '/';
const LoginRoute = '/login';
const SignupRoute = '/signup';
const LoanRoute = '/loan';
const DashboardRoute = '/dashboard';
const UsersRoute = '/users';
const PersonalInformationRoute = '/peronal';
const AddressVerificationRoute = '/address';
const IdentityVerificationRoute = '/identity';
void main() => runApp(MaterialApp(
      supportedLocales: [
        Locale('en')
      ],
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      onGenerateRoute: _routes(),
      home: LoanRequest(),

    ));

RouteFactory _routes() {
  return (settings) {
    Widget screen;
    switch (settings.name) {
      case LandingRoute:
        screen = LoanRequest();
        break;
      case LoginRoute:
        screen = Login();
        break;
      case SignupRoute:
        screen = Signup();
        break;
      case LoanRoute:
        screen = Loan();
        break;
      case DashboardRoute:
        screen = Dashboard();
        break;
      case UsersRoute:
        screen = Users();
        break;
      case PersonalInformationRoute:
        screen = PersonalInformation();
        break;
      case AddressVerificationRoute:
        screen = AddressVerification();
        break;
      case IdentityVerificationRoute:
        screen = IdentityVerification();
        break;
      default:
        return null;
    }

    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) => screen);
  };
}

/*
return Scaffold(
      appBar: AppBar(
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
                style: BorderStyle.solid,
                color: Colors.black,
                width: 1
              ),
              
            ),
          ),
        ],
      ),
      drawer: MainDrawer(),
    );

 Center(
        child: RaisedButton(
          onPressed: () {},
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Gradient Button',
              style: TextStyle(fontSize: 20)
            ),
          ),
        ),
        child: RaisedButton.icon(
          onPressed: () {}, 
          icon: Icon(
            Icons.mail,
            color: Colors.white,
          ), left
          label: Text(
            'Mail me',
            style: TextStyle(
              color: Colors.white 
            ),
          ),
          color: Colors.amber,
        )
        child: RaisedButton(
          onPressed: () {},
          color: Colors.amber,
          textColor: Colors.white,
          child:Text(
            'click me',
            style: TextStyle(
              fontFamily: 'IndieFlower',
              fontWeight: FontWeight.bold,
              fontSize: 30.0
            ),
          ),
        ),
        child: Icon(
          Icons.airport_shuttle,
          color: Colors.red,
          size: 80.0,
        ),
        child:Text(
          'Hello world',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
            color: Colors.grey[600],
            fontFamily: 'IndieFlower'
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null, 
        child: Text('click'),
        backgroundColor: Colors.red[600],
      ),

*/
