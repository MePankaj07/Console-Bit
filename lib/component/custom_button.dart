import 'package:console_bit/constants/color.dart';
import 'package:console_bit/constants/size.dart';

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final VoidCallback? press;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? getScreenHeight(45),
      width: width ?? getScreeWidth(335),
      decoration: BoxDecoration(
          color: primary, borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        onPressed: press,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(primary)),
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getTextSize(18),
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),
    );
  }
}
