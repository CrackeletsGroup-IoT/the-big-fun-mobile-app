import 'package:big_fun_app/infrastructure/inputs/payment/cvc.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/date_card.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/number_card.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/owner_card.dart';
import 'package:equatable/equatable.dart';

enum FormStatus { invalid, valid, validating, posting }

class PaymentFormState extends Equatable {
  
  final FormStatus formStatus;
  final bool isValid;
  final NumberCard numberCard;
  final OwnerCard ownerCard;
  final DateCard dateCard;
  final CVCCard cvcCard;

  const PaymentFormState({
    this.formStatus = FormStatus.invalid, 
    this.isValid = false,
    this.numberCard = const NumberCard.pure(),
    this.ownerCard = const OwnerCard.pure(),
    this.dateCard = const DateCard.pure(),
    this.cvcCard = const CVCCard.pure(),
  });

  PaymentFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    NumberCard? numberCard,
    OwnerCard? ownerCard,
    DateCard? dateCard,
    CVCCard? cvcCard,

  }) => PaymentFormState(
    formStatus: formStatus ?? this.formStatus,
    isValid: isValid ?? this.isValid,
    numberCard: numberCard ?? this.numberCard,
    ownerCard: ownerCard ?? this.ownerCard,
    dateCard: dateCard ?? this.dateCard,
    cvcCard: cvcCard ?? this.cvcCard,
  );
  

  @override
  List<Object> get props => [ formStatus, isValid, numberCard, ownerCard, dateCard, cvcCard ];
}
