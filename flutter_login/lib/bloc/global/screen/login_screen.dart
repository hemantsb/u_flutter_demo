import 'package:flutter/material.dart';
import 'blocs.dart';
import '../provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          emailField(bloc),
          passwordField(bloc),
          Container(
            margin: EdgeInsets.only(top: 25.0),
          ),
          submitButton(bloc)
        ],
      ),
    );
  }

  Widget emailField(Blocs bloc) {
    return StreamBuilder(
      stream: bloc.email,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changeEmail,
          decoration: InputDecoration(
              hintText: 'email@example.com',
              labelText: 'Email',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget passwordField(Blocs bloc) {
    return StreamBuilder(
      stream: bloc.password,
      builder: (context, snapshot) {
        return TextField(
          onChanged: bloc.changePassword,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'password',
              labelText: 'Password',
              errorText: snapshot.error),
        );
      },
    );
  }

  Widget submitButton(Blocs bloc) {
    return StreamBuilder(
      stream: bloc.submitValidation,
      builder: (context, snapshot) {
        return RaisedButton(
            child: Text('Submit'),
            onPressed: snapshot.hasData
                ? bloc.submit
                : null);
      },
    );
  }
}
