import 'package:flutter/material.dart';
import '../mixins/validation_auth.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with ValidationMixins{
  var formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            emailField(),
            passwordField(),
            Container(
              margin: EdgeInsets.only(top: 25.0),
            ),
            submitButton()
          ],
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      validator: validateEmail,
      onSaved: (email) {
        this.email = email;
      },
      decoration:
          InputDecoration(hintText: 'email@example.com', labelText: 'Email'),
    );
  }

  Widget passwordField() {
    return TextFormField(
      validator:validatePassword,
      onSaved: (password) {
        this.password = password;
      },
      obscureText: true,
      decoration: InputDecoration(hintText: 'password', labelText: 'Password'),
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Submit'),
      onPressed: () {
        if(formKey.currentState.validate()){
         formKey.currentState.save();
         print("Saved $email and $password");
        }
      },
    );
  }
}
