import 'package:formz/formz.dart';

// Define input validation errors
enum OwnerCardError { empty, length, invalid }

// Extend FormzInput and provide the input type and error type.
class OwnerCard extends FormzInput<String, OwnerCardError> {

  static RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  // Call super.pure to represent an unmodified form input.
  const OwnerCard.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const OwnerCard.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == OwnerCardError.empty ) return 'El campo es requerido';
    if ( displayError == OwnerCardError.length ) return 'Mínimo 4 caracteres';
    if ( displayError == OwnerCardError.invalid ) return 'Solo letras';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  OwnerCardError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return OwnerCardError.empty;
    if ( value.length < 4 ) return OwnerCardError.length;
    if ( !nameRegExp.hasMatch(value) ) return OwnerCardError.invalid;

    return null;
  }
}