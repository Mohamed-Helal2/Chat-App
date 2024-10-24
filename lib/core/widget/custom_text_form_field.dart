import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:mydoctor/core/theming/colors.dart';
// import 'package:mydoctor/core/theming/styling.dart';

class customTextFormField extends StatefulWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool? isobscureText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Function(String)? onChanged;
  final Color? fillColor;
  final Function(String?)? validator;
  final TextEditingController? controller;
  final Function(PointerDownEvent)? onTapOutside;
  final FocusNode? focusNode;
  final   Function()? onTap;
  const customTextFormField(
      {super.key,
      this.contentPadding,
      this.focusedBorder,
      this.enabledBorder,
      required this.hintText,
      this.hintStyle,
      this.style,
      this.isobscureText = false,
      this.suffixIcon,
      this.fillColor,
      this.validator,
      this.controller,
      this.prefixIcon,
      this.onChanged,
      this.onTapOutside,
      this.focusNode,this.onTap
      });

  @override
  State<customTextFormField> createState() => _customTextFormFieldState();
}

class _customTextFormFieldState extends State<customTextFormField> {
  TextDirection _textDirection = TextDirection.ltr;
  // Default LTR
  void _checkTextDirection(String text) {
    if (text.isNotEmpty) {
      // Check if the first character is RTL
      if (_isRTLCharacter(text[0])) {
        setState(() {
          _textDirection = TextDirection.rtl;
        });
      } else {
        setState(() {
          _textDirection = TextDirection.ltr;
        });
      }
    }
  }

  bool _isRTLCharacter(String character) {
    final int charCode = character.codeUnitAt(0);
    return (charCode >= 0x600 && charCode <= 0x6FF) || // Arabic
        (charCode >= 0x0590 && charCode <= 0x05FF); // Hebrew
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      // validator: (value) {
      //   return widget.validator!(value);
      // },
    focusNode:widget.focusNode ,
      textDirection: _textDirection,
      controller: widget.controller,
      onChanged: (value) {
        _checkTextDirection(value);
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      onTap: widget.onTap,
      onTapOutside: widget.onTapOutside,
      keyboardType: TextInputType.multiline,
      textInputAction: TextInputAction.newline,
      maxLines: widget.isobscureText! ? 1 : null,
      decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor ?? Colors.transparent,
          isDense: true,
          contentPadding: widget.contentPadding ??
              EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
// Focus
          focusedBorder: widget.focusedBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue, width: 1)),
// Enabled
          enabledBorder: widget.enabledBorder ??
              OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.black, width: 1)),
//Error               focusedBorder: focusedBorder ??
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.3)),
// FocusedErrorBorder
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.red, width: 1.3)),
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              TextStyle(fontSize: 14.sp, color: Colors.grey),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon),
      obscureText: widget.isobscureText ?? false,
      style: widget.style ?? TextStyle(fontSize: 16.sp, color: Colors.black),
    );
  }
}
