import 'package:flutter/cupertino.dart';
import 'package:flutter_application_todo/ui/theme.dart';

const blucolor = Color(0X90BEDE);
const blucolor2 = Color(0X7FEFBD);

class MyButton extends StatelessWidget {
  final String label;
  final Function()? onTap;
  const MyButton({Key? key, required this.label, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color.fromRGBO(242, 155, 59, 10),
        ),
        child: Center(
          child: Text(
            label,
            style: buttonStyle,
          ),
        ),
      ),
    );
  }
}
