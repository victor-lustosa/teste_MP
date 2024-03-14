import 'package:flutter/material.dart';

import 'form_field_widget.dart';


class DefaultFormFieldWidget extends StatefulWidget {
  const DefaultFormFieldWidget(
      {super.key,
        this.fieldKey,
        this.fieldWidth,
        required this.isValid,
        required this.title,
        required this.errorText,
        required this.validator,
        required this.controller,
        this.maxLines,
        this.maxLength,
        this.fieldHeight,
        this.titleMargin,
        this.isSubmitted,
        required this.inputDecoration,
        this.horizontalSymmetric,
        this.fieldDecoration,
        this.fieldMargin,
        this.titleStyle,
        this.fieldStyle,
        this.errorTextMargin,
        this.obscureText,
        this.cursorColor});

  final Key? fieldKey;
  final double? fieldWidth;
  final bool isValid;
  final String title;
  final String errorText;
  final FormFieldValidator validator;
  final EdgeInsetsGeometry? fieldMargin;
  final InputDecoration inputDecoration;
  final TextEditingController controller;
  final EdgeInsetsGeometry? horizontalSymmetric;
  final int? maxLines;
  final BoxDecoration? fieldDecoration;
  final Color? cursorColor;
  final int? maxLength;
  final double? fieldHeight;
  final TextStyle? titleStyle;
  final TextStyle? fieldStyle;
  final EdgeInsetsGeometry? titleMargin;
  final EdgeInsetsGeometry? errorTextMargin;
  final bool? isSubmitted;
  final bool? obscureText;
  @override
  State<DefaultFormFieldWidget> createState() => _DefaultFormFieldWidgetState();
}

class _DefaultFormFieldWidgetState extends State<DefaultFormFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.horizontalSymmetric,
      child: FormFieldWidget(
        titleMargin: widget.titleMargin,
        controller: widget.controller,
        fieldMargin: widget.fieldMargin,
        fieldKey: widget.fieldKey,
        fieldWidth: widget.fieldWidth,
        obscureText: widget.obscureText ?? false,
        fieldHeight: widget.fieldHeight ?? 42,
        cursorColor: widget.cursorColor ?? const Color(0xff979797),
        validator: widget.validator,
        maxLines: widget.maxLines ?? 1,
        maxLength: widget.maxLength,
        isSubmitted: widget.isSubmitted,
        title: widget.title,
        isValid: widget.isValid,
        errorText: Text(
          widget.errorText,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.red,
          ),
        ),
        inputDecoration: widget.inputDecoration,
        errorTextMargin: widget.errorTextMargin ??
            const EdgeInsets.only(
              top: 4,
              left: 2,
            ),
        fieldDecoration: widget.fieldDecoration ??
            BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: widget.isValid ? Colors.white : Colors.red,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
        titleStyle: widget.titleStyle ??
           const TextStyle(
              fontSize: 16,
              color: Colors.black26,
            ),
        fieldStyle: widget.fieldStyle ??
            TextStyle(
              fontSize: 14,
              color: widget.isValid ? const Color(0xff979797) : Colors.red,
            ),
      ),
    );
  }
}
