import 'dart:async';
import '../validators.dart';
import 'package:rxdart/rxdart.dart';

class Blocs extends Object with Validator {
  final emailController = BehaviorSubject<String>();
  final passwordController = BehaviorSubject<String>();

  Stream<String> get email =>
      emailController.stream.transform(validateEmail);
  Stream<String> get password =>
      passwordController.stream.transform(validPassword);

  Stream<bool> get submitValidation =>
      Observable.combineLatest2(email, password, (a, b) => true);

  Function(String) get changeEmail => emailController.sink.add;

  Function(String) get changePassword => passwordController.sink.add;

  submit(){
    final finalEmail = emailController.value;
    final finalPassword = passwordController.value;
    print("Email $finalEmail , Password $finalPassword");
  }
  dispose() {
    emailController.close();
    passwordController.close();
  }
}

//var bloc = Blocs();
