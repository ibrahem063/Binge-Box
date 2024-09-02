import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType tybe,
  final Function(String)? onFieldSubmitted,
  final Function(String)? onChanged,
  required String? Function(String?)? validator,
  final String? text,
  final String? label,
  Function()? onTap,
  double radius = 0.0,
  IconData? suffixIcon,
  IconData? pref,
  bool isPassword = false,
  Function()? suffixonPressed,
  bool isClickable = true,
  final double? width,
  final double? height,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
      alignment: Alignment.center,
      child: TextFormField(
        controller: controller,
        keyboardType: tybe,
        onFieldSubmitted: onFieldSubmitted,
        onChanged: onChanged,
        validator: validator,
        obscureText: isPassword,
        textAlign: TextAlign.start,
        onTap: onTap,
        enabled: isClickable,
        decoration: InputDecoration(
          prefixIcon: pref != null
              ? Icon(
            pref,
          )
              : null,
          hintText: text,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(radius),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          suffixIcon: IconButton(
            icon: Icon(suffixIcon),
            onPressed: suffixonPressed,
          ),
        ),
      ),
    );