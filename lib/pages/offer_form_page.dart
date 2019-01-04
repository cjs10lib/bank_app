import 'package:bank_app/scoped_models/main_model.dart';
import 'package:flutter/material.dart';
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

  DateTime _startDate;
  DateTime _endDate;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

  Widget _buildTitleFormField(BuildContext context) {
    return TextFormField(
      maxLength: 25,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          labelText: 'Title',
          hintText: 'Enter Title',
          filled: true,
          fillColor: Theme.of(context).cardColor),
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
      maxLength: 100,
      keyboardType: TextInputType.multiline,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      decoration: InputDecoration(
          labelText: 'Description',
          hintText: 'Enter Description',
          filled: true,
          fillColor: Theme.of(context).cardColor),
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
          labelText: 'Amount',
          hintText: 'Enter Amount',
          prefix: Text('GHC '),
          filled: true,
          fillColor: Theme.of(context).cardColor),
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
              prefixIcon: Icon(Icons.calendar_today),
              filled: true,
              fillColor: Theme.of(context).cardColor),
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
              prefixIcon: Icon(Icons.calendar_today),
              filled: true,
              fillColor: Theme.of(context).cardColor),
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
          child: Container(
            height: 50.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.center,
            child: model.isLoading
                ? CircularProgressIndicator()
                : Text('Save Offer',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold)),
          ),
        )
      ],
    );
  }

  _submitForm(MainModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    await model.createOffer(
      _formData['title'],
      _formData['description'],
      _formData['amount'],
      _startDate,
      _endDate,
    );

    _formKey.currentState.reset();
    _offerStartDateController.text = '';
    _offerEndDateController.text = '';
    _startDate = null;
    _endDate = null;

    Navigator.of(context).pushReplacementNamed('/tabs');
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
              appBar: AppBar(title: Text('Add Offers')),
              drawer: _buildSideDrawer(context),
              body: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, right: 20.0, left: 20.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image:
                              AssetImage('assets/login/login-background.jpg'))),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      children: <Widget>[
                        _buildTitleFormField(context),
                        SizedBox(height: 20.0),
                        _buildDescriptionFormField(context),
                        SizedBox(height: 20.0),
                        _buildAmountTextfield(context),
                        // SizedBox(height: 20.0),
                        _buildOfferStartDate(),
                        SizedBox(height: 20.0),
                        _buildOfferEndDate(),
                        SizedBox(height: 20.0),
                        _buildFormControl(context, model)
                      ],
                    ),
                  ),
                ),
              )),
        );
      },
    );
  }
}
