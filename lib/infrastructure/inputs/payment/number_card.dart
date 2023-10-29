import 'package:formz/formz.dart';

// Define input validation errors
enum NumberCardError { empty, length, invalid }

// Extend FormzInput and provide the input type and error type.
class NumberCard extends FormzInput<String, NumberCardError> {

  static final RegExp numberCardRegExp = RegExp(r'^[0-9]+$');

  // Call super.pure to represent an unmodified form input.
  const NumberCard.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const NumberCard.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == NumberCardError.empty ) return 'El campo es requerido';
    if ( displayError == NumberCardError.length ) return 'Debe tener 16 caracteres';
    if ( displayError == NumberCardError.invalid ) return 'Número de tarjeta inválido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  NumberCardError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return NumberCardError.empty;
    if ( value.length != 16 ) return NumberCardError.length;
    if ( !numberCardRegExp.hasMatch(value) ) return NumberCardError.invalid;
    return null;
  }
}