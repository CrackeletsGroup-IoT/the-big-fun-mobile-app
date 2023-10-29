import 'package:big_fun_app/infrastructure/blocs/payment/payment_cubit.dart';
import 'package:big_fun_app/widgets/card_type_icon.dart';
import 'package:big_fun_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';


class PaymentMethodView extends StatefulWidget {
  

  const PaymentMethodView({super.key});
  static const name = 'method-payment-view';
  


  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment method'),
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF6363A3),
      ),
      body: BlocProvider(
        create: (context) => PaymentCubit(),
        child: const _PaymentMethodView(),
      )
    );
  }
}

class _PaymentMethodView extends StatelessWidget {
  const _PaymentMethodView();

  @override
  Widget build(BuildContext context) {
    
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
              children: [
              SizedBox(height: 20),

              _PaymentMethodForm(),              

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaymentMethodForm extends StatelessWidget {
  const _PaymentMethodForm();

  @override
  Widget build(BuildContext context) {

    final paymentCubit = context.watch<PaymentCubit>();
    final numberCard = paymentCubit.state.numberCard;
    final ownerCard = paymentCubit.state.ownerCard;
    final dateCard = paymentCubit.state.dateCard;
    final cvcCard = paymentCubit.state.cvcCard;
    final cardIcon = CardTypeIcon(cardNumber: numberCard.value);

    return Form(
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Number card',
            onChanged: paymentCubit.numberCardChanged,
            errorMessage: numberCard.errorMessage,
            icon: cardIcon,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(16),
            ],
          ),
          const SizedBox(height: 20),
          
          CustomTextFormField(
            label: 'Owner card',
            onChanged: paymentCubit.ownerCardChanged,
            errorMessage: ownerCard.errorMessage,
            icon: const Icon(FontAwesomeIcons.user),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z ]')),
            ],
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'Date card (MM/YYYY)',
            onChanged: paymentCubit.dateCardChanged,
            errorMessage: dateCard.errorMessage,
            icon:const Icon(FontAwesomeIcons.calendar),
            inputFormatters: [
              LengthLimitingTextInputFormatter(7),
            ],
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'CVC',
            //obscureText: true,
            onChanged: paymentCubit.cvcCardChanged,
            errorMessage: cvcCard.errorMessage,
            icon:const Icon(FontAwesomeIcons.lock),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: (){
              paymentCubit.onSubmit();
            }, 
            icon: const Icon( Icons.credit_card),
            label: const Text('Add payment method'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFF6363A3)),
            ), 
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: (){
              context.pop();
            }, 
            icon: const Icon( Icons.cancel_presentation_rounded), 
            label: const Text('Cancel'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFF6363A3)),
            ), 
          )

        ],
      )
    );
  }
}



