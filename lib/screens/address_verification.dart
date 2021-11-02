import 'package:pisto/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/widgets/app_bar_widget.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddressVerification extends StatefulWidget {
  @override
  _AddressVerificationState createState() => _AddressVerificationState();
}

class _AddressVerificationState extends State<AddressVerification> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String,dynamic> _data;
  // ignore: unused_field
  Map<String, dynamic> _arguments = {};

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    TextStyle style = TextStyle(fontSize: 20.0);
    final String validName = r"^[a-zA-Z']+$";
    final String validHouse = r"^[a-zA-Z0-9\s']+$";
    _arguments = ModalRoute.of(context).settings.arguments;

    final steps = Container(
      height: 65.0,
      color: Colors.purple[50],
      // padding: EdgeInsets.fromLTRB(0.0, 8.0, 15.0, 8.0),
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
                    'Step 2',
                    style: TextStyle(
                        color: Color(0xff360167),
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
                Container(
                  width: 135.0,
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(
                    'Address'
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 60.0,
          ),
          Text('2/3',
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
              name: 'region',
              decoration: const InputDecoration(labelText: 'Region *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, validName,
                    errorText: 'Invalid Region Name.'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'city',
              decoration: const InputDecoration(labelText: 'City *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, validName,
                    errorText: 'Invalid City Name.'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'street',
              decoration: const InputDecoration(labelText: 'Street *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, validName,
                    errorText: 'Invalid Street Name.'),
              ]),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
            child: FormBuilderTextField(
              name: 'houseAddress',
              decoration: const InputDecoration(labelText: 'House Address *'),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(context),
                FormBuilderValidators.match(context, validHouse,
                    errorText: 'Invalid House Address.'),
              ]),
              keyboardType: TextInputType.text,
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
                    // _arguments['address'] = _data;
                  });
                  LoanRequestModel loan = LoanRequestModel();
                  loan.region = _data['region'];
                  loan.city = _data['city'];
                  loan.street = _data['street'];
                  loan.houseaddress = _data['houseAddress'];

                  LocalDatabaseHelper db = LocalDatabaseHelper.instance;
                  int res = await db.updateAddressInfo(loan);
                  if (res == 1) {
                    Navigator.pushNamed(
                        context, IdentityVerificationRoute);
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
