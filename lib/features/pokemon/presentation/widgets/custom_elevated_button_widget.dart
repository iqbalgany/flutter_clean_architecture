import 'package:flutter/material.dart';

class CustomElevatedButtonWidget extends StatelessWidget {
  final VoidCallback callback;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  const CustomElevatedButtonWidget({
    super.key,
    required this.callback,
    required this.buttonColor,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(buttonColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          minimumSize: WidgetStatePropertyAll(Size(double.infinity, 70)),
        ),
        onPressed: callback,
        child: Text('Search', style: TextStyle(fontSize: 25, color: textColor)),
      ),
    );
  }
}
