import 'package:pisto/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/widgets/app_bar_widget.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PersonalInformation extends StatefulWidget {
  @override
  _PersonalInformationState createState() => _PersonalInformationState();
}

enum SingingCharacter { male, female }

class _PersonalInformationState extends State<PersonalInformation> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _data;
  Map<String, dynamic> _arguments = {};

  @override
  Widget build(BuildContext context) {
    print("pInfo_init_settings: " + ModalRoute.of(context).settings.toString());
    _arguments = ModalRoute.of(context).settings.arguments;
    print("pInfo_init: " + _arguments.toString());
    TextStyle style = TextStyle(fontSize: 20.0);
    final String validName = r"^[a-zA-Z']+$";

    final steps = Container(
      height: 65.0,
      color: Colors.purple[50],
      child: Row(
        children: [
          MaterialButton(
            onPressed: () {},
            color: Color(0xff360167),
            textColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 34.0,
            ),
            padding: EdgeInsets.all(6.0),
            shape: CircleBorder(),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 6),
                  width: 130.0,
                  child: Text(
                    'Step 1',
                    style: TextStyle(
                        color: Color(0xff360167),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
                Container(
                  width: 135.0,
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text('Personal Information'),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60.0,
          ),
          Text('1/3',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
        ],
      ),
    );

    final forms = FormBuilder(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 55.0, 10.0, 0.0),
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
              name: 'password',
              decoration: const InputDecoration(labelText: 'Password *'),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              keyboardType: TextInputType.text,
              obscureText: true,
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
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            width: 200.0,
            child: ElevatedButton(
              onPressed: () async {
                // Validate returns true if the form is valid, or false
                // otherwise.
                _formKey.currentState.save();
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  setState(() {
                    _data = _formKey.currentState.value;
                    // _arguments['peronalInfo'] = _data;
                  });

                  print(_data);
                  LoanRequestModel loan = LoanRequestModel();
                  loan.firstname = _data['firstname'];
                  loan.lastname = _data['lastname'];
                  loan.gender = _data['gender'];
                  loan.dateofbirth = _data['dateofbirth'].toString();
                  loan.idnumber = _data['idnumber'];
                  loan.password = _data['password'];
                  loan.email = _data['email'];
                  loan.phone = _data['phone'];

                  LocalDatabaseHelper db = LocalDatabaseHelper.instance;
                  int res = await db.updatePersonalInfo(loan);
                  if (res == 1) {
                    Navigator.pushNamed(
                        context, AddressVerificationRoute);
                  }
                }
              },
              child: Text('Next'),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
        appBar: MyAppBar(),
        drawer: MainDrawer(),
        body: Center(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [forms],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: steps,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
