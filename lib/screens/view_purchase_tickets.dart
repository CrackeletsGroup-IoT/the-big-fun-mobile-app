import 'package:big_fun_app/infrastructure/blocs/purchase/purchase_cubit.dart';
import 'package:big_fun_app/models/event.dart';
import 'package:big_fun_app/services/event_service.dart';
import 'package:big_fun_app/utils/functions.dart';
import 'package:big_fun_app/views/payment_method_view.dart';
import 'package:big_fun_app/widgets/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ViewPurchaseTickets extends StatefulWidget {
  final String eventId;
  const ViewPurchaseTickets({
    super.key,
    required this.eventId,
  });
  static const name = 'purchase-tickets-view';

  @override
  State<ViewPurchaseTickets> createState() => _ViewPurchaseTicketsState();
}

class _ViewPurchaseTicketsState extends State<ViewPurchaseTickets> {
  EventService? _eventService;
  Event? event;

  @override
  void initState() {
    super.initState();
    _eventService = EventService();
    initialize(); 
  }

  Future initialize() async {
    event = await _eventService!.getById(widget.eventId);
    setState(() {
      event = event;
    });
  }

  @override
  Widget build(BuildContext context) {
    final image = getImageEvent(event?.image ??
        "https://blog.sinapsis.agency/wp-content/uploads/2021/04/DEFINICIONES.-ERROR-404.png");


    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF6363A3),
        title: Text('Purchase tickets - ${event?.name}'),
      ),
      body: BlocProvider(
        create: (context) => PurchaseCubit(),
        child: _PurchaseView(image: image, eventId: event?.id),
      ),
      
    );
  }
}


class _PurchaseView extends StatelessWidget {
  final ImageProvider image;
  final int? eventId;
  const _PurchaseView({
    required this.image,
    required this.eventId
  });
  
  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            
            children: [
        
              Image(
                image: image,
              ),

              const SizedBox(height: 20),

              _PurchaseForm(eventId: eventId),              

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


class _PurchaseForm extends StatelessWidget {
  final int? eventId;
  const _PurchaseForm({
    required this.eventId
  });

  @override
  Widget build(BuildContext context) {

    final purchaseCubit = context.watch<PurchaseCubit>();
    final name = purchaseCubit.state.name;
    final lastname = purchaseCubit.state.lastname;
    final email = purchaseCubit.state.email;
    final cellphone = purchaseCubit.state.cellphone;
    final amount = purchaseCubit.state.amount;
    

    return Form(
      child: Column(
        children: [

          CustomTextFormField(
            label: 'Name',
            onChanged: purchaseCubit.nameChanged,
            errorMessage: name.errorMessage,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
          ),
          const SizedBox(height: 20),
          
          CustomTextFormField(
            label: 'Lastname',
            onChanged: purchaseCubit.lastnameChanged,
            errorMessage: lastname.errorMessage,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
            ],
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'Email',
            onChanged: purchaseCubit.emailChanged,
            errorMessage: email.errorMessage,
            icon:const Icon(FontAwesomeIcons.envelope),
          ),
          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'Cellphone',
            onChanged: purchaseCubit.cellphoneChanged,
            errorMessage: cellphone.errorMessage,
            icon:const Icon(FontAwesomeIcons.phone),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(9),
            ],
          ),

          const SizedBox(height: 20),

          CustomTextFormField(
            label: 'Amount',
            onChanged: purchaseCubit.amountChanged,
            errorMessage: amount.errorMessage,
            icon:const Icon(FontAwesomeIcons.ticket),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(2),
            ],
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: () => showDialog(
              context: context, 
              builder: (BuildContext context) => const Dialog(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: PaymentMethodView(),
                ),
              )
            ),
            icon: const Icon(Icons.add_card_outlined),
            label: const Text('Payment method'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFF6363A3)),
            ), 
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: (){
              purchaseCubit.onSubmit();
              //context.go('/attendants/payment-successful/$eventId');
            }, 
            icon: const Icon( Icons.shopping_cart),
            label: const Text('Buy tickets'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFF6363A3)),
            ), 
          ),

          const SizedBox(height: 20),

          FilledButton.tonalIcon(
            onPressed: (){
              context.go('/attendants/events');
            }, 
            icon: const Icon( Icons.cancel_outlined),
            label: const Text('Cancel'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(const Color(0xFF6363A3)),
            ), 
          ),

        ],
      )
    );
  }
}