import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/main.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/services/mongo_service_helper.dart';
import 'package:pisto/widgets/loading_spinner.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Login extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<Login> {
  TextStyle style = TextStyle(fontSize: 20.0);
  // ignore: unused_field
  String _eml = '';
  // ignore: unused_field
  String _pass = '';
  bool _isVisible = false;
  String _notice = 'No email found';
  bool _isLoading = false;
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _data;
  @override
  Widget build(BuildContext context) {
    /*
    final emailField = Container(
        height: 45.0,
        child: TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Email',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
          onChanged: (text) {
            _eml = text;
          },
        ));

    final passwordField = Container(
        height: 45.0,
        child: TextField(
          obscureText: true,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Password',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
          onChanged: (text) {
            _pass = text;
          },
        ));

    final loginButton = Container(
      height: 45.0,
      child: RaisedButton(
        onPressed: () async {
          setState(() {
            _isLoading = true;
          });
          Map<String, dynamic> res = await AuthService().login(_eml, _pass);
          if (res.containsKey('error')) {
            setState(() {
              _isLoading = false;
              _isVisible = true;
              _notice = res['error'];
            });
          } else {
            UserLoginModel user = UserLoginModel();
            user.id = res['_id'].toHexString();
            user.name = res['name'];
            user.email = res['email'];
            user.isLogin = res['islogin'];
            user.loginDate = res['logindate'].toString();
            user.picture = res['picture'];
            user.loans = res['loans'];

            LocalDatabaseHelper db = LocalDatabaseHelper.instance;
            await db.insertLogin(user);
            setState(() {
              _isLoading = false;
            });

            Navigator.pushReplacementNamed(context, LandingRoute);
          }
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
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
              borderRadius: BorderRadius.circular(32.0)),
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "Login",
              style: style.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    final forgotPasswordButton = Container(
      height: 45.0,
      child: OutlineButton(
        onPressed: () {},
        child: Text('Forgot your password?'),
        borderSide: BorderSide(
          style: BorderStyle.none,
        ),
      ),
    );

    final loginWithFaceBook = Container(
      child: FlatButton(
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {},
        color: Colors.grey[100],
        child: Text('Login with Facebook'),
      ),
    );
*/
    final signupButton = Container(
      height: 45.0,
      child: OutlinedButton(
        onPressed: () {
          Navigator.pushNamed(context, SignupRoute);
        },
        child: Text('Register'),
        style: OutlinedButton.styleFrom(
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(18.0),
          // ),
          side: BorderSide(style: BorderStyle.none),
   ),
      ),
    );

    final noticeText = Container(
      alignment: Alignment.center,
      child:
          Text('$_notice', style: TextStyle(color: Colors.red, fontSize: 16.0)),
    );

    final loginForm = FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(labelText: 'Email Address*'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.email(context,
                    errorText: 'Invalid email address.')
              ]),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'password',
              decoration: const InputDecoration(labelText: 'Password *'),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              keyboardType: TextInputType.text,
              obscureText: true,
              onChanged: (value) => setState(() {
                _pass = value;
              }),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: 200.0,
            child: ElevatedButton(
              onPressed: () async {
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  setState(() {
                    _isVisible = false;
                    _isLoading = true;
                    _data = _formKey.currentState.value;
                  });

                  Map<String, dynamic> res = await AuthService()
                      .login(_data['email'], _data['password']);
                  if (res.containsKey('error')) {
                    setState(() {
                      _isLoading = false;
                      _isVisible = true;
                      _notice = res['error'];
                    });
                  } else {
                    UserLoginModel user = UserLoginModel();
                    user.id = res['_id'].toHexString();
                    user.name = res['name'];
                    user.email = res['email'];
                    user.role = res['role'];
                    user.isLogin = res['islogin'];
                    user.loginDate = res['logindate'].toString();
                    user.picture = res['picture'];
                    user.loans = res['loans'];

                    LocalDatabaseHelper db = LocalDatabaseHelper.instance;
                    await db.userLogin(user);
                    setState(() {
                      _isLoading = false;
                    });

                    Navigator.pushReplacementNamed(context, LandingRoute);
                  }
                }
              },
              child: Text('Login'),
            ),
          ),
          signupButton,
        ],
      ),
    );

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Log in to your account to request a loan',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'IndieFlower',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  if (_isVisible) noticeText,
                  if (_isLoading) LoadingSpinner(),
                  SizedBox(height: 10.0),
                  loginForm
                  /*
                  emailField,
                  SizedBox(
                    height: 15.0,
                  ),
                  passwordField,
                  SizedBox(
                    height: 20.0,
                  ),
                  loginButton,
                  signupButton,
                  forgotPasswordButton,
                  loginWithFaceBook,
                  */
                ],
              ),
            ),
          ),
        ));
  }
}
