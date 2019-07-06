import 'package:dream_cars/src/services/login_service.dart';
import 'package:dream_cars/src/utils/alerts.dart';
import 'package:dream_cars/src/utils/response.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final _userController = TextEditingController(text: 'lj@lj.com');
  final _passwordController = TextEditingController(text: '123456');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dream Cars'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _body(context),
      ),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          TextFormField(
            controller: _userController,
            validator: _validateUser,
            textCapitalization: TextCapitalization.none,
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              labelText: 'User'.toUpperCase(),
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          TextFormField(
            controller: _passwordController,
            validator: _validatePassword,
            obscureText: true,
            textCapitalization: TextCapitalization.none,
            style: TextStyle(color: Theme.of(context).primaryColor),
            decoration: InputDecoration(
              labelText: 'Password'.toUpperCase(),
              labelStyle: TextStyle(color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 50,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text(
                'Login'.toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => _onClickLogin(context),
            ),
          ),
        ],
      ),
    );
  }

  String _validateUser(String text) {
    if (text.isEmpty) return 'User field is required';
    if (text.length < 2) return 'User field length should be greater than 2';
    return null;
  }

  String _validatePassword(String text) {
    if (text.isEmpty) return 'Password field is required';
    if (text.length < 3)
      return 'Password field length should be greater than 3';
    return null;
  }

  Future _onClickLogin(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    final response = await LoginService.login(
        _userController.text, _passwordController.text);

    if (response.isOk()) {
      print(response.message);
    } else {
      alert(context, 'Error', response.message);
    }
  }
}
