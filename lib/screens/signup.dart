import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/main.dart';
// ignore: unused_import
import 'package:pisto/models/local_db_models.dart';
// ignore: unused_import
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/services/mongo_service_helper.dart';
import 'package:pisto/widgets/loading_spinner.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class Signup extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<Signup> {
  TextStyle style = TextStyle(fontSize: 20.0);
  String _eml = '';
  String _pass = '';
  // ignore: unused_field
  String _fnm = '';
  // ignore: unused_field
  String _lnm = '';
  // ignore: unused_field
  String _cpass = '';
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _data = {'role': 'standard'};
  final String validName = r"^[a-zA-Z']+$";
  String _notice = '';
  bool _isVisible = false;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final firstNameField = Container(
        height: 45.0,
        child: TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'First Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
          onChanged: (text) {
            _fnm = text;
          },
        ));

    final lastNameField = Container(
        height: 45.0,
        child: TextField(
          obscureText: false,
          style: style,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
              hintText: 'Last Name',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32.0))),
          onChanged: (text) {
            _lnm = text;
          },
        ));

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

    final cPasswordField = Container(
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
            _cpass = text;
          },
        ));

    final submitButton = Container(
      height: 45.0,
      child: ElevatedButton(
        onPressed: () async {
          Map<String, dynamic> res = await AuthService().login(_eml, _pass);
          Navigator.pushReplacementNamed(context, LandingRoute);
        },
        style: ElevatedButton.styleFrom(
          shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(32.0)),
            padding: EdgeInsets.all(0.0),
        ),
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
              "Submit",
              style: style.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    final loginButton = Container(
      height: 45.0,
      child: OutlinedButton(
        onPressed: () {},
        child: Text('Remembered your account? Login'),
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            style: BorderStyle.none,
        ),
        )
        
      ),
    );

    final signupForm = FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: FormBuilderTextField(
              name: 'firstname',
              decoration: const InputDecoration(labelText: 'First Name *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, validName,
                    errorText: 'Invalid Name.'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'lastname',
              decoration: const InputDecoration(labelText: 'Last Name *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, validName,
                    errorText: 'Invalid Name.'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ),
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
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
                name: 'confirmpassword',
                decoration:
                    const InputDecoration(labelText: 'Confirm Password *'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(context),
                  FormBuilderValidators.equal(context, _pass,
                      errorText: 'Password mismatch')
                ]),
                keyboardType: TextInputType.text,
                obscureText: true),
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
                    _data.addAll(_formKey.currentState.value);
                  });
                  // setState(() {
                  //   _data['role'] = 'standard';
                  // });

                  Map<String, dynamic> res = await AuthService().signup(_data);
                  if (res.containsKey('success')) {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.pushNamed(context, LoginRoute);
                  } else {
                    setState(() {
                      _isLoading = false;
                      _isVisible = true;
                      _notice = res['error'];
                    });
                  }
                }
              },
              child: Text('Submit'),
            ),
          ),
          loginButton,
        ],
      ),
    );

    final noticeText = Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      child:
          Text('$_notice', style: TextStyle(color: Colors.red, fontSize: 16.0)),
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
                      'Signup to request a loan',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'IndieFlower',
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  if (_isVisible) noticeText,
                  if (_isLoading) LoadingSpinner(),
                  signupForm
                  // firstNameField,
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // lastNameField,
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // emailField,
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // passwordField,
                  // SizedBox(
                  //   height: 15.0,
                  // ),
                  // cPasswordField,
                  // SizedBox(
                  //   height: 20.0,
                  // ),
                  // submitButton,
                  // loginButton,
                  // forgotPasswordButton,
                  // loginWithFaceBook,
                ],
              ),
            ),
          ),
        ));
  }
}

/*
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderRadioGroup(
              decoration: InputDecoration(labelText: 'Gender'),
              name: 'gender',
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              options: ['Male', 'Female']
                  .map((lang) => FormBuilderFieldOption(
                        value: lang,
                        child: Text('$lang'),
                      ))
                  .toList(growable: false),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderDateTimePicker(
              name: 'dateofbirth',
              // onChanged: _onChanged,
              inputType: InputType.date,
              decoration: InputDecoration(
                labelText: 'Date of Birth',
              ),
              // initialTime: TimeOfDay(hour: 8, minute: 0),
              // initialValue: DateTime.now(),
              // enabled: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'idnumber',
              decoration: const InputDecoration(labelText: 'ID Number *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, r'^[a-zA-Z0-9]+$',
                    errorText: 'Invalid Number.'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'phone',
              decoration: const InputDecoration(labelText: 'Phone Number *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, r"^\+[0-9]+$",
                    errorText: 'Number should start with a plus(+).')
              ]),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          */
