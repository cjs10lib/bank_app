import 'dart:io';

import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileImageUploadPage extends StatefulWidget {
  final Function _navigateForward;
  final Function _navigateBackwards;

  ProfileImageUploadPage(this._navigateForward, this._navigateBackwards);

  @override
  _ProfileImageUploadPageState createState() => _ProfileImageUploadPageState();
}

class _ProfileImageUploadPageState extends State<ProfileImageUploadPage> {
  File _imageFile;

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ScopedModelDescendant(
              builder: (BuildContext context, Widget child, MainModel model) {
            return Container(
              height: 250.0,
              padding: EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Select an option',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Material(
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120.0,
                            height: 120,
                            child: Icon(Icons.camera,
                                size: 100.0,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        onTap: () {
                          _getImage(ImageSource.camera, model);
                        },
                      ),
                      SizedBox(width: 20.0),
                      GestureDetector(
                        child: Material(
                          elevation: 2.0,
                          child: Container(
                            padding: EdgeInsets.all(10.0),
                            width: 120.0,
                            height: 120.0,
                            child: Icon(Icons.image,
                                size: 100.0,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        onTap: () {
                          _getImage(ImageSource.gallery, model);
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          });
        });
  }

  void _getImage(ImageSource source, MainModel model) {
    model.getAuthenticatedUser();

    ImagePicker.pickImage(source: source, maxWidth: 200.0, maxHeight: 200.0)
        .then((File image) {
      if (image != null) {
        setState(() {
          _imageFile = image;
          model.selectProfileImage(image);
        });
      }

      Navigator.of(context).pop();
    });
  }

  Widget _buildImagePlaceHolder(MainModel model) {
    return Container(
        height: 250.0,
        width: 250.0,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(125.0),
            border: Border.all(color: Colors.white, width: 2.0)),
        child: model.profileImage != null
            // ? FadeInImage(
            //     fit: BoxFit.cover,
            //     image: NetworkImage(model.profileImage),
            //     placeholder: AssetImage('assets/avatar/avatar.png'))

            ? ClipRRect(
                borderRadius: BorderRadius.circular(10000.0),
                child: FadeInImage(
                    fit: BoxFit.cover,
                    height: 200.0,
                    width: 200.0,
                    image: NetworkImage(model.profileImage),
                    placeholder: AssetImage('assets/avatar/avatar.png')))
            : CircleAvatar(
                radius: 125.0,
                backgroundImage: _imageFile == null
                    ? AssetImage('assets/avatar/avatar.png')
                    : FileImage(_imageFile)));
  }

  Widget _buildFormcontrols(MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            widget._navigateBackwards();
          },
          child: Container(
            height: 40.0,
            width: 80.0,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: Text('Back',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        model.isLoading
            ? Container(
                height: 40.0,
                width: 120.0,
                padding: EdgeInsets.all(5.0),
                color: Color.fromRGBO(59, 70, 80, 1),
                alignment: Alignment.center,
                child: CircularProgressIndicator())
            : GestureDetector(
                onTap: () => _submitForm(model),
                child: Container(
                  height: 40.0,
                  width: 160.0,
                  // color: Color.fromRGBO(0, 25, 45, .40),
                  color: Color.fromRGBO(59, 70, 80, 1),
                  alignment: Alignment.center,
                  child: Text('Save & Continue',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
                ),
              )
      ],
    );
  }

  Future _submitForm(MainModel model) async {
    if (_imageFile == null) {
      print('Select Image!');
    } else {
      Map<String, dynamic> successInformation =
          await model.uploadProfileImage();

      _returnMessage(successInformation);
    }
  }

  void _returnMessage(Map<String, dynamic> successInformation) {
    if (successInformation['success']) {
      widget._navigateForward();
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Oops! Something went wrong'),
              content: Text(successInformation['message']),
              actions: <Widget>[
                FlatButton(
                  child: Text('Okay'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    }
  }

  Widget _buildSkipControl() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      FlatButton(
        child: Text(
          'Skip profile image upload',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        onPressed: () => widget._navigateForward(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      return Container(
          child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _buildImagePlaceHolder(model),
              SizedBox(height: 10),
              FlatButton(
                child: Text('Select Image',
                    style: TextStyle(fontSize: 20.0, color: Colors.white)),
                onPressed: () {
                  print('Select Image');
                  _openImagePicker(context);
                },
              ),
              SizedBox(height: 50.0),
              _buildFormcontrols(model),
              SizedBox(height: 50.0),
              model.profileImage == null ? Container() : _buildSkipControl()
            ],
          ),
        ),
      ));
    });
  }
}
