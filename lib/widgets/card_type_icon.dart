import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardTypeIcon extends StatefulWidget {
  final String cardNumber;
  const CardTypeIcon({
    super.key,
    required this.cardNumber,
  });

  @override
  State<CardTypeIcon> createState() => _CardTypeIconState();
}

class _CardTypeIconState extends State<CardTypeIcon> {
  @override
  Widget build(BuildContext context) {
    IconData cardIcon = determineCardTypeIcon(widget.cardNumber);
    return Icon(cardIcon, size: 32);
  }

  IconData determineCardTypeIcon(String cardNumber) {
    if (cardNumber.startsWith('4')) {
      return FontAwesomeIcons.ccVisa;
    } else if (cardNumber.startsWith('5')) {
      return FontAwesomeIcons.ccMastercard;
    } else if (cardNumber.startsWith('3')) {
      return FontAwesomeIcons.ccAmex;
    } else {
      return FontAwesomeIcons.creditCard;
    }
  }
}
