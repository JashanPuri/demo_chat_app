import 'dart:io';

import 'package:flutter/material.dart';

import 'pick_image.dart';

class AuthForm extends StatefulWidget {
  final Function(
    String email,
    String password,
    String username,
    File userImageFile,
    bool isLogin,
    BuildContext ctx,
  ) submitAuthFrom;

  final bool isLoading;

  AuthForm({this.submitAuthFrom, this.isLoading});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();

  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  var _isLogin = true;

  File _userImageFile;

  void _pickUserImage(File imageFile) {
    _userImageFile = imageFile;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      print(_userEmail);
      print(_userName);
      print(_userPassword);
      widget.submitAuthFrom(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) PickImage(_pickUserImage),
                    TextFormField(
                      key: ValueKey('email'),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email address',
                      ),
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Invalid Email';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userEmail = newValue;
                      },
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('username'),
                        decoration: InputDecoration(
                          labelText: 'Username',
                        ),
                        validator: (value) {
                          if (value.isEmpty || value.contains(' ')) {
                            return 'Invalid Username';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userName = newValue;
                        },
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be atlesat 7 characters long';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        _userPassword = newValue;
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    widget.isLoading
                        ? CircularProgressIndicator()
                        : RaisedButton(
                            child: Text(_isLogin ? 'Login' : 'Sign Up'),
                            onPressed: _trySubmit,
                          ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin ? 'Sign Up' : 'Login'),
                      textColor: Theme.of(context).primaryColor,
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
