import 'package:big_fun_app/infrastructure/blocs/payment/payment_state.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/cvc.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/date_card.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/number_card.dart';
import 'package:big_fun_app/infrastructure/inputs/payment/owner_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PaymentCubit extends Cubit<PaymentFormState> {
  PaymentCubit() : super(const PaymentFormState());

  void onSubmit() {
    emit(state.copyWith(
        formStatus: FormStatus.validating,
        numberCard: NumberCard.dirty(state.numberCard.value),
        ownerCard: OwnerCard.dirty(state.ownerCard.value),
        dateCard: DateCard.dirty(state.dateCard.value),
        cvcCard: CVCCard.dirty(state.cvcCard.value),
        isValid: Formz.validate([
          state.numberCard,
          state.ownerCard,
          state.dateCard,
          state.cvcCard
        ])));
    
  }

  void numberCardChanged(String value) {
    final numberCard = NumberCard.dirty(value);

    emit(state.copyWith(
        numberCard: numberCard,
        isValid: Formz.validate(
            [numberCard, state.ownerCard, state.dateCard, state.cvcCard])));
  }

  void ownerCardChanged(String value) {
    final ownerCard = OwnerCard.dirty(value);
    emit(state.copyWith(
        ownerCard: ownerCard,
        isValid: Formz.validate(
            [ownerCard, state.numberCard, state.dateCard, state.cvcCard])));
  }

  void dateCardChanged(String value) {
    final dateCard = DateCard.dirty(value);
    emit(state.copyWith(
        dateCard: dateCard,
        isValid: Formz.validate(
            [dateCard, state.numberCard, state.ownerCard, state.cvcCard])));
  }

  void cvcCardChanged(String value) {
    final cvcCard = CVCCard.dirty(value);
    emit(state.copyWith(
        cvcCard: cvcCard,
        isValid: Formz.validate(
            [cvcCard, state.numberCard, state.ownerCard, state.dateCard])));
  }

}
