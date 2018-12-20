import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:bank_app/models/auth.dart';
import 'package:bank_app/scoped_models/main_model.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Map<String, dynamic> _formData = {'email': null, 'password': null};

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

  Widget _buildEmailTextField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-Mail',
        hintText: 'Enter username',
      ),
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'Password', hintText: 'Enter password'),
      controller: _passwordController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password should be 6+ characters';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          hintText: 'Enter password confirmation'),
      validator: (String value) {
        if (_passwordController.text != value) {
          return 'Passwords do not match!';
        }
      },
    );
  }

  Widget _buildForgotPasswordControl() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('Forgot Password?'),
      ],
    );
  }

  Widget _buildLoginControl(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return model.isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(10.0),
                  child: GestureDetector(
                    onTap: () => _submitForm(model),
                    child: Container(
                      height: 40.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: Text(
                          _authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.0)),
                    ),
                  ),
                ),
              );
      },
    );
  }

  Future _submitForm(MainModel model) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    Map<String, dynamic> successInformation = await model.authenticate(
        _formData['email'], _formData['password'], _authMode);

    _returnAuthMessage(successInformation, model);
  }

  Future _returnAuthMessage(
      Map<String, dynamic> successInformation, MainModel model) async {
    if (successInformation['success']) {
      // fetch authenticatedUser details
      model.isLoading = true;
      await model.fetchProfile();
      await model.fetchAccount();
      await model.fetchProfileImage();
      model.isLoading = false;

      if (_authMode == AuthMode.Login && model.profile == null) {
        Navigator.of(context).pushReplacementNamed('/sign-up');
      } else if (_authMode == AuthMode.Login &&
          model.profile != null &&
          model.accountStatus == null) {
        Navigator.of(context).pushReplacementNamed('/sign-up');
      } else if (_authMode == AuthMode.Login &&
          model.profile != null &&
          model.accountStatus != null) {
        if (!model.accountStatus.isActivated) {
          Navigator.of(context).pushReplacementNamed('/pending-activation');
        } else if (_authMode == AuthMode.Login &&
            model.accountStatus.isActivated) {
          Navigator.of(context).pushReplacementNamed('/tabs');
        }
      } else if (_authMode == AuthMode.Signup) {
        Navigator.of(context).pushReplacementNamed('/sign-up');
      }

      // _authMode == AuthMode.Login
      //     ? Navigator.of(context).pushReplacementNamed('/tabs')
      //     : Navigator.of(context).pushReplacementNamed('/sign-up');
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

  Widget _buildAuthModeControl(BuildContext context) {
    return Container(
      height: 50.0,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: Material(
        elevation: 1.0,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _authMode == AuthMode.Login
                  ? 'Not registered account yet?'
                  : 'Already have an account?',
              style: TextStyle(color: Colors.grey[700]),
            ),
            SizedBox(width: 10.0),
            GestureDetector(
                child: Text(_authMode == AuthMode.Login ? 'Sign Up' : 'Login',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                onTap: () {
                  setState(() {
                    _authMode == AuthMode.Login
                        ? _authMode = AuthMode.Signup
                        : _authMode = AuthMode.Login;

                    _formKey.currentState.reset();
                    _passwordController.text = '';
                  });
                })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/login/login-background.jpg'),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(.5), BlendMode.darken),
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      // Image.asset('assets/logo/cua-logo-white.png'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset('assets/logo/white-cu-logo.png',
                              height: 100.0, width: 100.0),
                          SizedBox(width: 10.0),
                          Column(
                            children: <Widget>[
                              Text('KAMCCU CORP',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold)),
                              Text('CREDIT UNION',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold)),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        // height: _authMode == AuthMode.Login ? 400.0 : 470.0,
                        width: 350.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Card(
                          child: Container(
                            padding: EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  _authMode == AuthMode.Login
                                      ? 'Login'
                                      : 'Sign Up',
                                  style: TextStyle(
                                    fontSize: 40.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                _buildEmailTextField(),
                                SizedBox(height: 15.0),
                                _buildPasswordTextField(),
                                SizedBox(height: 15.0),
                                _authMode == AuthMode.Signup
                                    ? _buildConfirmPasswordTextField()
                                    : Container(),
                                SizedBox(height: 15.0),
                                _authMode == AuthMode.Login
                                    ? _buildForgotPasswordControl()
                                    : Container(),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    _buildLoginControl(context),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      _buildAuthModeControl(context),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
