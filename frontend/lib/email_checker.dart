import 'package:email_validator/email_validator.dart';

void main() {
  bool isValid = EmailValidator.validate('justasj3#!#!justas@gmail.com');
  print((isValid) ? 'Valid' : 'Not valid');
}
