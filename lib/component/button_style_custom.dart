import 'package:flutter/material.dart';
// import 'package:flutter_application_testme/Components/color.dart';

class ButtonStyleCustom extends StatelessWidget {
  final String textid;
  final color;
  final Function()? onTap;
  const ButtonStyleCustom(
      {super.key, required this.textid, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            // color: clientColor,
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
              child: Text(textid,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  )))),
    );
  }
}
