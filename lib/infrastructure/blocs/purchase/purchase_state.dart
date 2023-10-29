import 'package:big_fun_app/infrastructure/inputs/purchase/amount_tickets.dart';
import 'package:big_fun_app/infrastructure/inputs/purchase/cellphone.dart';
import 'package:big_fun_app/infrastructure/inputs/purchase/email.dart';
import 'package:big_fun_app/infrastructure/inputs/purchase/lastname.dart';
import 'package:big_fun_app/infrastructure/inputs/purchase/name.dart';
import 'package:equatable/equatable.dart';

enum FormStatus { invalid, valid, validating, posting }

class PurchaseFormState extends Equatable {
  
  final FormStatus formStatus;
  final bool isValid;
  final Name name;
  final Lastname lastname;
  final Email email;
  final Cellphone cellphone;
  final AmountTickets amount;

  const PurchaseFormState({
    this.formStatus = FormStatus.invalid, 
    this.isValid = false,
    this.name = const Name.pure(),
    this.lastname = const Lastname.pure(), 
    this.email = const Email.pure(), 
    this.cellphone= const Cellphone.pure(),
    this.amount = const AmountTickets.pure(),
  });

  PurchaseFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    Name? name,
    Lastname? lastname,
    Email? email,
    Cellphone? cellphone,
    AmountTickets? amount,
  }) => PurchaseFormState(
    formStatus: formStatus ?? this.formStatus,
    isValid: isValid ?? this.isValid,
    name: name ?? this.name,
    lastname: lastname ?? this.lastname,
    email: email ?? this.email,
    cellphone: cellphone ?? this.cellphone,
    amount: amount ?? this.amount,
  );
  

  @override
  List<Object> get props => [ formStatus, isValid, name, lastname, email, cellphone, amount ];
}
