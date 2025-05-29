import 'package:flutter/material.dart';

class InfoText extends StatelessWidget {
  const InfoText({super.key, required this.label, required this.info});
  final String label;
  final String info;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: label,
          style: Theme.of(context).textTheme.bodyMedium,
          children: [TextSpan(text: info)]),
    );
  }
}

class WhieContainer extends StatelessWidget {
  const WhieContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white54,
      elevation: 3,
      borderRadius: BorderRadius.circular(15.0),
      child: Padding(padding: EdgeInsets.all(16),child: child,),
    );
  }
}
