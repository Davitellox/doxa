import 'package:flutter/material.dart';

class SmalltileCustom extends StatelessWidget {
  final String imgPath;

  const SmalltileCustom({super.key, required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey.shade200),
      child: Image.asset(
        imgPath,
        height: 40,
      ),
    );
  }
}
