import 'package:formz/formz.dart';

// Define input validation errors
enum LastnameError { empty, length }

// Extend FormzInput and provide the input type and error type.
class Lastname extends FormzInput<String, LastnameError> {

  // Call super.pure to represent an unmodified form input.
  const Lastname.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Lastname.dirty( String value ) : super.dirty(value);


  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == LastnameError.empty ) return 'El campo es requerido';
    if ( displayError == LastnameError.length ) return 'Mínimo 2 caracteres';

    return null;
  }


  // Override validator to handle validating a given input value.
  @override
  LastnameError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return LastnameError.empty;
    if ( value.length < 2 ) return LastnameError.length;

    return null;
  }
}