import 'dart:io';

import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class OfferFormPage extends StatefulWidget {
  @override
  OfferFormPageState createState() {
    return new OfferFormPageState();
  }
}

class OfferFormPageState extends State<OfferFormPage> {
  Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'amount': 0
  };

  File _imageFile;
  DateTime _startDate;
  DateTime _endDate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _offerStartDateController = TextEditingController();
  TextEditingController _offerEndDateController = TextEditingController();

  Future _selectOfferDate(BuildContext context, bool startDate) async {
    if (startDate) {
      _startDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(new Duration(days: 1)),
          firstDate: DateTime.now().subtract(new Duration(days: 30)),
          lastDate: DateTime.now().add(Duration(days: 1)),
          initialDatePickerMode: DatePickerMode.day);
      if (_startDate != null) {
        setState(() {
          _offerStartDateController.text =
              '${_startDate.day}/${_startDate.month}/${_startDate.year}';
        });
      }
    } else {
      _endDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now().add(new Duration(days: 1)),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(new Duration(days: 60)),
          initialDatePickerMode: DatePickerMode.day);
      if (_endDate != null) {
        setState(() {
          _offerEndDateController.text =
              '${_endDate.day}/${_endDate.month}/${_endDate.year}';
        });
      }
    }
  }

  Widget _buildSideDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            automaticallyImplyLeading: false,
            title: Text('Menu Items'),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(child: Icon(Icons.local_offer)),
                  title: Text('Add Offers'),
                ),
                ListTile(
                  leading:
                      CircleAvatar(child: Icon(Icons.store_mall_directory)),
                  title: Text('Offers'),
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed('/tabs');
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildOfferBasicDetailsContainer() {
    return Material(
      elevation: 1.0,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Text('OFFER DETAILS',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Text('Basic Information',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildTitleFormField(context),
            SizedBox(height: 20.0),
            _buildDescriptionFormField(context),
            SizedBox(height: 20.0),
            _buildAmountTextfield(context)
          ],
        ),
      ),
    );
  }

  Widget _buildOfferDatesContainer() {
    return Material(
      elevation: 1.0,
      color: Theme.of(context).cardColor,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: <Widget>[
            Text('OFFER DETAILS',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            Divider(color: Colors.grey),
            Text('Offer Dates Information',
                style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold)),
            _buildOfferStartDate(),
            SizedBox(height: 20.0),
            _buildOfferEndDate(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleFormField(BuildContext context) {
    return TextFormField(
      maxLength: 20,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(labelText: 'Title', hintText: 'Enter Title'),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Offer title is required!';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
    );
  }

  Widget _buildDescriptionFormField(BuildContext context) {
    return TextFormField(
      maxLines: 3,
      keyboardType: TextInputType.multiline,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          labelText: 'Description', hintText: 'Enter Description'),
      validator: (String value) {
        if (value.isEmpty || value.length < 30) {
          return 'Description is required and should be 30+ characters';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
    );
  }

  Widget _buildAmountTextfield(BuildContext context) {
    return TextFormField(
      maxLength: 7,
      keyboardType: TextInputType.number,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          labelText: 'Amount', hintText: 'Enter Amount', prefix: Text('GHC ')),
      validator: (String value) {
        if (value.isEmpty || double.parse(value) <= 0) {
          return 'Amount is required!';
        }
      },
      onSaved: (String value) {
        _formData['amount'] = double.parse(value);
      },
    );
  }

  Widget _buildOfferStartDate() {
    return GestureDetector(
      onTap: () {
        _selectOfferDate(context, true);
      },
      child: AbsorbPointer(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _offerStartDateController,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
          decoration: InputDecoration(
              labelText: 'Start Date',
              hintText: 'Select Start Date',
              prefixIcon: Icon(Icons.calendar_today)),
          validator: (String value) {
            if (value.isEmpty ||
                _offerStartDateController.text.isEmpty ||
                _startDate == null) {
              return 'Offer start-date is required!';
            }
          },
        ),
      ),
    );
  }

  Widget _buildOfferEndDate() {
    return GestureDetector(
      onTap: () {
        _selectOfferDate(context, false);
      },
      child: AbsorbPointer(
        child: TextFormField(
          keyboardType: TextInputType.number,
          controller: _offerEndDateController,
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
          decoration: InputDecoration(
              labelText: 'End Date',
              hintText: 'Select End Date',
              prefixIcon: Icon(Icons.calendar_today)),
          validator: (String value) {
            if (value.isEmpty ||
                _offerEndDateController.text.isEmpty ||
                _endDate == null) {
              return 'Offer end-date is required!';
            }
          },
        ),
      ),
    );
  }

  Widget _buildFormControl(BuildContext context, MainModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: model.isLoading
              ? null
              : () {
                  _submitForm(model);
                },
          child: Material(
            elevation: 2.0,
            child: Container(
              height: 50.0,
              width: 160.0,
              padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
              // color: Theme.of(context).primaryColor,
              color: Color.fromRGBO(59, 70, 80, 1),
              alignment: Alignment.center,
              child: model.isLoading
                  ? CircularProgressIndicator()
                  : Text('Save Offer',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold)),
            ),
          ),
        )
      ],
    );
  }

  _submitForm(MainModel model) async {
    if (_imageFile == null) {
      final snackbar =
          SnackBar(content: Text('Select an offer image before proceeding!'));
      _scaffoldKey.currentState.showSnackBar(snackbar);
      return;
    }

    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    Map<String, dynamic> _imageSuccessMessage =
        await model.uploadOfferImage(_imageFile);

    if (_imageSuccessMessage['success']) {
      Map<String, dynamic> _successMessage = await model.createOffer(
          _formData['title'],
          _formData['description'],
          _formData['amount'],
          _startDate,
          _endDate,
          _imageSuccessMessage['donwloadUrl']);

      _formKey.currentState.reset();
      _offerStartDateController.text = '';
      _offerEndDateController.text = '';
      _startDate = null;
      _endDate = null;

      Navigator.of(context).pushReplacementNamed('/tabs');
    } else {
      print(_imageSuccessMessage['downloadUrl']); // error message
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Scaffold(
              key: _scaffoldKey,
              drawer: _buildSideDrawer(context),
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    expandedHeight: 350.0,
                    // snap: true,
                    // floating: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.add_a_photo,
                          size: 30.0,
                        ),
                        onPressed: () {
                          _openImagePicker(context);
                        },
                      )
                    ],
                    flexibleSpace: FlexibleSpaceBar(
                      title: Text('Offer Image'),
                      background: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image:
                                AssetImage('assets/login/login-background.jpg'),
                          ),
                        ),
                        child: _imageFile == null
                            ? Image.asset('assets/login/login-background.jpg',
                                fit: BoxFit.cover)
                            : Image.file(_imageFile, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 20.0, right: 20.0, left: 20.0),
                          color: Theme.of(context).primaryColor,
                          child: ListView(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            children: <Widget>[
                              _buildOfferBasicDetailsContainer(),
                              SizedBox(height: 20.0),
                              _buildOfferDatesContainer(),
                              SizedBox(height: 20.0),
                              _buildFormControl(context, model),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                        // ),
                      ),
                    ]),
                  )
                ],
              )),
        );
      },
    );
  }
}
