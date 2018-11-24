import 'dart:async';
import '../validators.dart';

class Blocs extends Object with Validator {
  final emailController = StreamController<String>();
  final passwordController = StreamController<String>();

  Stream<String> get email => emailController.stream.transform(validateEmail);

  Stream<String> get password =>
      passwordController.stream.transform(validPassword);

  Function(String) get changeEmail => emailController.sink.add;

  Function(String) get changePassword => passwordController.sink.add;

  dispose() {
    emailController.close();
    passwordController.close();
  }
}

var bloc = Blocs();
