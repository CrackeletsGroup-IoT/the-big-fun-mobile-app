import 'package:big_fun_app/utils/formulario_payment/blocs/purchase/purchase_state.dart';
import 'package:big_fun_app/utils/formulario_payment/inputs/purchase/amount_tickets.dart';
import 'package:big_fun_app/utils/formulario_payment/inputs/purchase/cellphone.dart';
import 'package:big_fun_app/utils/formulario_payment/inputs/purchase/email.dart';
import 'package:big_fun_app/utils/formulario_payment/inputs/purchase/lastname.dart';
import 'package:big_fun_app/utils/formulario_payment/inputs/purchase/name.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class PurchaseCubit extends Cubit<PurchaseFormState> {
  PurchaseCubit() : super(const PurchaseFormState());

  void onSubmit() {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        name: Name.dirty( state.name.value ),
        lastname: Lastname.dirty( state.lastname.value ),
        email: Email.dirty( state.email.value ),
        cellphone: Cellphone.dirty( state.cellphone.value ),
        amount: AmountTickets.dirty( state.amount.value ),

        isValid: Formz.validate([
          state.name,
          state.lastname, 
          state.email,
          state.cellphone,
          state.amount
        ])
      )
    );
  }


  void nameChanged( String value ) {
    final name = Name.dirty(value);
    emit(
      state.copyWith(
        name: name,
        isValid: Formz.validate([ name, state.lastname, state.email, state.cellphone, state.amount ])
      )
    );
  }

  void lastnameChanged( String value ) {
    final lastname = Lastname.dirty(value);
    emit(
      state.copyWith(
        lastname: lastname,
        isValid: Formz.validate([ lastname, state.name, state.email, state.cellphone, state.amount ])
      )
    );
  }

  void emailChanged( String value ) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([ email, state.name, state.lastname, state.cellphone, state.amount ])
      )
    );
  }

  void cellphoneChanged( String value ) {
    final cellphone = Cellphone.dirty(value);
    emit(
      state.copyWith(
        cellphone: cellphone,
        isValid: Formz.validate([ cellphone, state.name, state.lastname, state.email, state.amount ])
      )
    );
  }

  void amountChanged( String value ) {
    final amount = AmountTickets.dirty(value);
    emit(
      state.copyWith(
        amount: amount,
        isValid: Formz.validate([ amount, state.name, state.lastname, state.email, state.cellphone ])
      )
    );
  }


}
