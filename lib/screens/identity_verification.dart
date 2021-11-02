import 'dart:convert';
import 'dart:io';
import 'package:pisto/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:pisto/models/image_upload_model.dart';
import 'package:pisto/models/local_db_models.dart';
import 'package:pisto/screens/main_drawer.dart';
import 'package:pisto/services/local_db_helper.dart';
import 'package:pisto/services/mongo_service_helper.dart';
import 'package:pisto/widgets/app_bar_widget.dart';

class IdentityVerification extends StatefulWidget {
  @override
  _IdentityVerificationState createState() => _IdentityVerificationState();
}



class _IdentityVerificationState extends State<IdentityVerification> {
  final _formKey = GlobalKey<FormBuilderState>();
  Map<String, dynamic> _data = {};
  List<Object> images = List<Object>();
  Future<File> _imageFile;
  Map<String, dynamic> _arguments = {};
  final double _imageHeight = 70;
  final double _imageWidth = 103;

  @override
  void initState() {
    super.initState();
    setState(() {
      images.add("Add Image");
      images.add("Add Image");
      images.add("Add Image");
      _data = {'id_front': '', 'id_back': '', 'id_selfie': ''};
    });
  }

  void getFileImage(int index) async {
//    var dir = await path_provider.getTemporaryDirectory();
    _imageFile.then((file) async {
      final imageBytes = await file.readAsBytesSync();
      String base64Image = base64.encode(imageBytes);
      switch (index) {
        case 0:
          setState(() {
            _data['id_front'] = base64Image;
          });
          break;
        case 1:
          setState(() {
            _data['id_back'] = base64Image;
          });
          break;
        case 2:
          setState(() {
            _data['id_selfie'] = base64Image;
          });
          break;
        default:
          return null;
      }

      setState(() {
        ImageUploadModel imageUpload = new ImageUploadModel();
        imageUpload.isUploaded = false;
        imageUpload.uploading = false;
        imageUpload.imageFile = file;
        imageUpload.imageUrl = '';
        images.replaceRange(index, index + 1, [imageUpload]);
      });
    });
  }

  Future _onAddImageClick(int index) async {
    setState(() {
      _imageFile = ImagePicker.pickImage(source: ImageSource.gallery);
      getFileImage(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 20.0);
    _arguments = ModalRoute.of(context).settings.arguments;

    Widget buildGridView() {
      return Container(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(images.length, (index) {
              if (images[index] is ImageUploadModel) {
                ImageUploadModel uploadModel = images[index];
                return Container(
                  child: Stack(
                    children: <Widget>[
                      Image.file(
                        uploadModel.imageFile,
                        width: _imageWidth,
                        height: _imageHeight,
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: InkWell(
                          child: Icon(
                            Icons.remove_circle,
                            size: 20,
                            color: Colors.red,
                          ),
                          onTap: () {
                            setState(() {
                              images.replaceRange(
                                  index, index + 1, ['Add Image']);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                    margin: EdgeInsets.only(bottom: 30.0),
                    width: _imageWidth,
                    height: _imageHeight,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26)),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _onAddImageClick(index);
                      },
                    ));
              }
            }),
          ));
    }

    Widget steps() {
      return Container(
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
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 6),
                    width: 130.0,
                    child: Text(
                      'Step 3',
                      style: TextStyle(
                          color: Color(0xff360167),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0),
                    ),
                  ),
                  Container(
                    width: 135.0,
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text('Identity Verification'),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 60.0,
            ),
            Text('3/3',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
          ],
        ),
      );
    }

    Widget infoBuilder() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
            child: Text(
              'Almost There!',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Text(
              'To verify you will need to upload a photo. See below for samples',
              style: TextStyle(
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 20),
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset("images/id_front.png",
                    width: _imageWidth, height: _imageHeight, fit: BoxFit.fill),
                Image.asset("images/id_back.png",
                    width: _imageWidth, height: _imageHeight, fit: BoxFit.fill),
                Image.asset("images/id_selfie.jpg",
                    width: _imageWidth, height: _imageHeight, fit: BoxFit.fill)
              ],
            ),
          ),
        ],
      );
    }

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
                      children: [
                        SizedBox(
                          height: 60,
                        ),
                        Container(
                          child: infoBuilder(),
                        ),
                        Container(
                          child: buildGridView(),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 40.0),
                          width: 200.0,
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                // _arguments['idInfo'] = _data;
                              });
                              if (!_data.containsValue('')) {
                                // print(_data);
                                LoanRequestModel loan = LoanRequestModel();
                                loan.idfront = _data['id_front'];
                                loan.idback = _data['id_back'];
                                loan.idselfie = _data['id_selfie'];

                                // print(loan.idfront);

                                LocalDatabaseHelper db =
                                    LocalDatabaseHelper.instance;
                                int res = await db.updateIdInfo(loan);
                                if (res == 1) {
                                  int resp = await LoanService().sendRequest();

                                  if (resp == 1) {
                                    db.deleteLoanReq();
                                    Navigator.pushReplacementNamed(
                                        context, LandingRoute,
                                        arguments: {'lrs': 'success'});
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Notice'),
                                          content: Text(
                                              'Request failed. Please try again.'),
                                          actions: [
                                            FlatButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                Navigator.pushReplacementNamed(
                                                    context, LandingRoute);
                                              },
                                            ),
                                            FlatButton(
                                              child: Text("Ok"),
                                              onPressed: () async {
                                                Navigator.of(context).pop();
                                                resp = await LoanService()
                                                    .sendRequest();
                                              },
                                            )
                                          ],
                                        );
                                      },
                                    );
                                  }
                                }
                              }
                            },
                            child: Text('Send Request'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      child: steps(),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
    /*
        body: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                child: steps(),
              ),
            ),
            Container(
              child: infoBuilder(),
            ),
            Container(
              child: buildGridView(),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              width: 200.0,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    // _arguments['idInfo'] = _data;
                  });
                  if (!_data.containsValue('')) {
                    // print(_data);
                    LoanRequestModel loan = LoanRequestModel();
                    loan.idfront = _data['id_front'];
                    loan.idback = _data['id_back'];
                    loan.idselfie = _data['id_selfie'];

                    // print(loan.idfront);

                    LocalDatabaseHelper db = LocalDatabaseHelper.instance;
                    int res = await db.updateIdInfo(loan);
                    if (res == 1) {
                      int resp = await LoanService().sendRequest();

                      
                      if (resp == 1) {
                        db.deleteLoanReq();
                        Navigator.pushReplacementNamed(context, LandingRoute,arguments: {'lrs':'success'});
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Notice'),
                              content:
                                  Text('Request failed. Please try again.'),
                              actions: [
                                FlatButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.pushReplacementNamed(
                                        context, LandingRoute);
                                  },
                                ),
                                FlatButton(
                                  child: Text("Ok"),
                                  onPressed: () async {
                                    Navigator.of(context).pop();
                                    resp = await LoanService().sendRequest();
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }
                      
                    }
                  } 
                },
                child: Text('Send Request'),
              ),
            ),
          ],
        ));
        */
  }
}
