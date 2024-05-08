import 'package:flutter/material.dart';
class DropDownText extends StatelessWidget {
  const DropDownText({
    super.key,
    required this.label,
    required this.icon,
    required this.buttonRack,
  });

  final String label;
  final IconData icon;
  final List<Widget> buttonRack;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          label,
          style: const TextStyle(
            fontFamily: 'Capriola',
          ),
        ),
        leading: Icon(icon),
        childrenPadding: const EdgeInsets.only(left: 60),
        children: buttonRack,
      ),
    );
  }
}