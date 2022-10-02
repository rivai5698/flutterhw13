import 'package:flutter/material.dart';

const colorConst = Colors.green;
class MyButton extends StatefulWidget {
  final Color color;
  final double width;
  final double height;
  final String text;
  final Color textColor;
  final VoidCallback onPressed;

  const MyButton({super.key, this.color = colorConst, this.width = double.infinity, this.height = 50, required this.text, this.textColor = Colors.black, required this.onPressed});



  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        widget.onPressed();
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(4),
        ),
        width: widget.width,
        height: widget.height,
        child: Center(
          child: Text(widget.text,style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: widget.textColor,
          ),),
        ),
      ),
    );
  }
}
