import 'package:formz/formz.dart';

// Define input validation errors
enum CVCError { empty, length, invalid }

// Extend FormzInput and provide the input type and error type.
class CVCCard extends FormzInput<String, CVCError> {

  static final RegExp cvcCardRegExp = RegExp(r'^[0-9]+$');

  // Call super.pure to represent an unmodified form input.
  const CVCCard.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const CVCCard.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == CVCError.empty ) return 'El campo es requerido';
    if ( displayError == CVCError.length ) return 'Debe tener 3 caracteres';
    if ( displayError == CVCError.invalid ) return 'Número cvc inválido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CVCError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return CVCError.empty;
    if ( value.length != 3 ) return CVCError.length;
    if ( !cvcCardRegExp.hasMatch(value) ) return CVCError.invalid;
    return null;
  }
}