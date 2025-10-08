import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class FocusNotesTextFormfield extends StatefulWidget {
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String? hintText;
  final bool obscureText;
  const FocusNotesTextFormfield({
    super.key,
    this.obscureText = false,
    this.validator,
    required this.controller,
    this.hintText,
  });

  @override
  State<FocusNotesTextFormfield> createState() =>
      _FocusNotesTextFormfieldState();
}

class _FocusNotesTextFormfieldState extends State<FocusNotesTextFormfield> {
  bool isShownPassword = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SizeConstants.s24,
        vertical: SizeConstants.s12,
      ),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
        ), // styling the color of input which better be always black
        controller: widget.controller,
        obscureText: isShownPassword ? false : widget.obscureText,
        validator: widget.validator,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(SizeConstants.s12),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),

          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isShownPassword = !isShownPassword;
                    });
                  },
                  icon: isShownPassword
                      ? Icon(
                          Icons.visibility,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                )
              : null,
        ),
      ),
    );
  }
}
