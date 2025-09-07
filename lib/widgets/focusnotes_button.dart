import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';

class FocusNotesButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool isLoading;
  const FocusNotesButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(SizeConstants.s24),
        margin: const EdgeInsets.symmetric(horizontal: SizeConstants.s24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(SizeConstants.s12),
        ),
        child: isLoading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.surfaceBright,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConstants.s16,
                ),
              ),
      ),
    );
  }
}
