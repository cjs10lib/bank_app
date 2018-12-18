import 'package:bank_app/models/profile.dart';
import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfileEditPage extends StatefulWidget {
  final Function _navigateForward;

  ProfileEditPage(this._navigateForward);

  @override
  _ProfileEditPageState createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final Map<String, dynamic> _formData = {
    'firstname': null,
    'lastname': null,
    'mobilePhone': null,
    'otherPhone': null
  };

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildFirstNameTextField(Profile profile) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'First Name',
      ),
      initialValue: profile != null ? profile.firstname : null,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Firstname is required!';
        }
      },
      onSaved: (String value) {
        _formData['firstname'] = value;
      },
    );
  }

  Widget _buildLastNameTextField(Profile profile) {
    return TextFormField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Last Name',
      ),
      initialValue: profile != null ? profile.lastname : null,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Lastname is required!';
        }
      },
      onSaved: (String value) {
        _formData['lastname'] = value;
      },
    );
  }

  Widget _buildMobilePhoneTextField(Profile profile) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 9,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Mobile Phone',
          prefixText: '+233 ',
          suffixIcon: Icon(Icons.phone_android)),
      initialValue: profile != null ? profile.mobilePhone : null,
      validator: (String value) {
        if (value.isEmpty) {
          return 'Mobile phone number is required!';
        }
      },
      onSaved: (String value) {
        _formData['mobilePhone'] = value;
      },
    );
  }

  Widget _buildOtherPhoneTextField(Profile profile) {
    return TextFormField(
      keyboardType: TextInputType.phone,
      maxLength: 9,
      decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Other Phone',
          prefixText: '+233 ',
          suffixIcon: Icon(Icons.local_phone)),
      initialValue: profile != null ? profile.otherPhone : null,
      onSaved: (String value) {
        _formData['otherPhone'] = value;
      },
    );
  }

  Widget _buildFormControls(BuildContext context, MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/');
          },
          child: Container(
            height: 40.0,
            width: 80.0,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: Text('Signout',
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
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Map<String, dynamic> successInformation = await model.createProfile(
        _formData['firstname'],
        _formData['lastname'],
        _formData['mobilePhone'],
        _formData['otherPhone']);

    _returnMessage(successInformation);
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
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: <Widget>[
      FlatButton(
        child: Text(
          'Skip profile form',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        onPressed: () => widget._navigateForward(),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double _deviceWidth = MediaQuery.of(context).size.width;
    double _targetWidth = _deviceWidth > 550.0 ? 500.0 : _deviceWidth * .90;

    return ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget child, MainModel model) {
      final _profile = model.profile;

      return Container(
          child: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            width: _targetWidth,
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 50.0),
                  Text(
                    'Your account is not yet activated!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                      'Complete the registration process by navigate through the signup wizard to activate your account',
                      style: TextStyle(color: Colors.white, fontSize: 16.0)),
                  SizedBox(height: 40),
                  _buildFirstNameTextField(_profile),
                  SizedBox(height: 20.0),
                  _buildLastNameTextField(_profile),
                  SizedBox(height: 20.0),
                  _buildMobilePhoneTextField(_profile),
                  _buildOtherPhoneTextField(_profile),
                  SizedBox(height: 30),
                  _buildFormControls(context, model),
                  SizedBox(height: 20),
                  model.profile == null ? Container() : _buildSkipControl()
                ],
              ),
            ),
          ),
        ),
      ));
    });
  }
}
