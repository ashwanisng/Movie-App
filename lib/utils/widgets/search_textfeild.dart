import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef SearchCallback = Function(String s);

class SearchTextField extends StatelessWidget {
  final Icon? suffixIcon;
  final String? hintText;
  final Color fillColor;
  final TextEditingController? controller;
  final SearchCallback? searchCallback;
  final bool autoFocus;

  const SearchTextField({
    Key? key,
    this.hintText,
    this.suffixIcon,
    required this.fillColor,
    required this.searchCallback,
    required this.controller,
    this.autoFocus = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enableInteractiveSelection: false,
      textAlignVertical: TextAlignVertical.center,
      onChanged: searchCallback,
      autofocus: autoFocus,
      textInputAction: TextInputAction.search,
      cursorColor: Colors.grey,
      style: const TextStyle(fontSize: 16, color: Colors.grey),
      decoration: InputDecoration(
        isDense: true,
        prefixIcon: const Icon(
          CupertinoIcons.search,
          size: 20.0,
          color: Colors.grey,
        ),
        suffixIcon: const Icon(
          CupertinoIcons.mic,
          size: 20.0,
          color: Colors.grey,
        ),
        fillColor: fillColor,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
        border: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.yellow[100]!,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(0.0),
        ),
      ),
    );
  }
}
