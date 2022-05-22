
import 'package:flutter/material.dart';
class CommonValueContainer extends StatelessWidget {
  final String text;
  final String value;
  const CommonValueContainer({Key? key, required this.text, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width/1.3,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Text( value),
          ],
        ),
      ),
    );
  }
}
