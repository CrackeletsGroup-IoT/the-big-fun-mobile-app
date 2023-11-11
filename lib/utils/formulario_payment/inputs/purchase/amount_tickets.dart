import 'package:formz/formz.dart';

// Define input validation errors
enum AmountTicketsError { empty, invalid }

// Extend FormzInput and provide the input type and error type.
class AmountTickets extends FormzInput<String, AmountTicketsError> {

  static final RegExp amountTicketsRegExp = RegExp(r'^[0-9]+$');
  
  // Call super.pure to represent an unmodified form input.
  const AmountTickets.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const AmountTickets.dirty( String value ) : super.dirty(value);

  String? get errorMessage {
    if ( isValid || isPure ) return null;

    if ( displayError == AmountTicketsError.empty ) return 'El campo es requerido';
    if ( displayError == AmountTicketsError.invalid ) return 'La cantidad de tickes inválido';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  AmountTicketsError? validator(String value) {
    final parsedValue = int.tryParse(value);

    if ( value.isEmpty || value.trim().isEmpty ) return AmountTicketsError.empty;
    if (parsedValue == null) return AmountTicketsError.invalid;
    if ( parsedValue <= 0 ) return AmountTicketsError.invalid;
    if ( !amountTicketsRegExp.hasMatch(value) ) return AmountTicketsError.invalid;
    return null;
  }
}