import 'package:flutter/material.dart';

/// A responsive TextFormField that adapts its width based on screen size
class AdaptiveTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final double maxWidth;
  final double mobileWidthFactor;

  const AdaptiveTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.validator,
    this.maxWidth = 200,
    this.mobileWidthFactor = 0.9,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width > 500
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * mobileWidthFactor,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color.fromARGB(178, 132, 77, 151),
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 2,
            vertical: 16,
          ),
          labelStyle: TextStyle(
            color: Color.fromARGB(178, 132, 77, 151),
            fontSize: MediaQuery.sizeOf(context).width > 400 ? 16 : 14,
          ),
        ),
      ),
    );
  }
}

/// A responsive ElevatedButton that adapts its width based on screen size
class AdaptiveElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final double maxWidth;
  final double mobileWidthFactor;
  final ButtonStyle? style;

  const AdaptiveElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.maxWidth = 600,
    this.mobileWidthFactor = 0.9,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width > 500
            ? MediaQuery.of(context).size.width * 0.4
            : MediaQuery.of(context).size.width * mobileWidthFactor,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: style ??
            ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(178, 132, 77, 151),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: const Size(double.infinity, 50),
            ),
        child: child,
      ),
    );
  }
}
