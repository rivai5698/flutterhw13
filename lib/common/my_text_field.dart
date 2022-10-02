import 'package:flutter/material.dart';

const textCapitalizationConst = TextCapitalization.sentences;
class MyTextField extends StatefulWidget {
  final String text;
  final TextInputType textInputType;
  final int maxLength;
  final bool obscureText;
  final TextCapitalization textCapitalization;
  final int maxLines,minLines;

  const MyTextField({super.key, required this.text, this.textInputType = TextInputType.text, this.maxLength = 100, this.obscureText = false, this.textCapitalization = textCapitalizationConst, this.maxLines = 1, this.minLines = 1});



  @override
  State<MyTextField> createState() => _MyTextFieldsState();
}

class _MyTextFieldsState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        textCapitalization: widget.textCapitalization,
        keyboardType: widget.textInputType,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        maxLength: widget.maxLength,
        obscureText: widget.obscureText,
        autocorrect: false,
        decoration: InputDecoration(
          counterText: '',
          labelText: widget.text,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
    );
  }
}
