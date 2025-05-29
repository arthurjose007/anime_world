import 'package:flutter/material.dart';

class IosBackButton extends StatelessWidget {
  const IosBackButton(
      {super.key, this.borderWidth = 2.0, required this.onPressed});
  final VoidCallback onPressed;
  final double borderWidth;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 35,
          height: 35,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Theme.of(context).shadowColor,
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.arrow_back_ios_new,
              size: 20,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
