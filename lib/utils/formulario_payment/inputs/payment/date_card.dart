import 'package:formz/formz.dart';

// Define input validation errors
enum DateCardError { empty, invalid, expired }

// Extend FormzInput and provide the input type and error type.
class DateCard extends FormzInput<String, DateCardError> {
  static final RegExp dateCardRegExp = RegExp(r'^[0-9]{2}/[0-9]{4}$');
  static final DateTime now = DateTime.now();

  // Call super.pure to represent an unmodified form input.
  const DateCard.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const DateCard.dirty(String value) : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == DateCardError.empty) return 'El campo es requerido';
    if (displayError == DateCardError.invalid) return 'Fecha de vencimiento inválida';
    if (displayError == DateCardError.expired) return 'Tarjeta expirada';
    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  DateCardError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return DateCardError.empty;
    if (!dateCardRegExp.hasMatch(value)) return DateCardError.invalid;

    final parts = value.split('/');
    if (parts.length != 2) return DateCardError.invalid;

    final month = int.tryParse(parts[0]);
    final year = int.tryParse(parts[1]);

    if (month == null || year == null) return DateCardError.invalid;

    final expirationDate = DateTime(year, month, 1);

    if (expirationDate.isBefore(now)) return DateCardError.expired;

    return null;
  }
}
