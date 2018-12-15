import 'package:flutter/material.dart';

enum AuthMode { Signup, Login }

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  AuthMode _authMode = AuthMode.Login;

  Widget _buildEmailTextField() {
    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: 'E-Mail',
        hintText: 'Enter username',
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      obscureText: true,
      decoration:
          InputDecoration(labelText: 'Password', hintText: 'Enter password'),
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Confirm Password',
          hintText: 'Enter password confirmation'),
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
    return Expanded(
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10.0),
        child: GestureDetector(
          onTap: () {
            print('Navigating to tabs page');
            Navigator.of(context).pushReplacementNamed('/tabs');
          },
          child: Container(
            height: 40.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
            ),
            child: Text(_authMode == AuthMode.Login ? 'Login' : 'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
          ),
        ),
      ),
    );
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
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
                onTap: () {
                  setState(() {
                    _authMode == AuthMode.Login
                        ? _authMode = AuthMode.Signup
                        : _authMode = AuthMode.Login;
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
                child: Column(
                  children: <Widget>[
                    Image.asset('assets/logo/cua-logo-white.png'),
                    SizedBox(height: 20.0),
                    Container(
                      height: _authMode == AuthMode.Login ? 390.0 : 430.0,
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
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              _buildEmailTextField(),
                              SizedBox(height: 20.0),
                              _buildPasswordTextField(),
                              SizedBox(height: 20.0),
                              _authMode == AuthMode.Signup
                                  ? _buildConfirmPasswordTextField()
                                  : Container(),
                              SizedBox(height: 20.0),
                              _authMode == AuthMode.Login
                                  ? _buildForgotPasswordControl()
                                  : Container(),
                              SizedBox(height: 30.0),
                              Row(
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
    );
  }
}
