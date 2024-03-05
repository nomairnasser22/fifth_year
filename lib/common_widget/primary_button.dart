import 'package:flutter/material.dart';

import '../common/color_extensions.dart';

class PrimaryButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final double size;
  final FontWeight fontWeight;

  const PrimaryButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.size = 16,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: const DecorationImage(
              image: AssetImage("assets/img/primary_btn.png"),
            ),
            boxShadow: [
              BoxShadow(
                color: TColor.secondary.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 4),
              ),
            ]),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: TColor.white, fontSize: size, fontWeight: fontWeight),
        ),
      ),
    );
  }
}
