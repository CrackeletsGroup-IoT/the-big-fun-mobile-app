import 'package:formz/formz.dart';

// Define input validation errors
enum CellphoneError { empty, length, invalid }

// Extend FormzInput and provide the input type and error type.
class Cellphone extends FormzInput<String, CellphoneError> {

  static final RegExp cellphoneRegExp = RegExp(r'^[0-9]+$');

  // Call super.pure to represent an unmodified form input.
  const Cellphone.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Cellphone.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == CellphoneError.empty ) return 'El campo es requerido';
    if ( displayError == CellphoneError.length ) return 'Debe tener 9 digitos';
    if ( displayError == CellphoneError.invalid ) return 'Número de celular inválido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  CellphoneError? validator(String value) {

    if ( value.isEmpty || value.trim().isEmpty ) return CellphoneError.empty;
    if ( value.length != 9 ) return CellphoneError.length;
    if ( !cellphoneRegExp.hasMatch(value) ) return CellphoneError.invalid;
    return null;
  }
}