import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomedTextBox extends StatelessWidget {
  const CustomedTextBox(
      {required this.labelText,
      this.hintText,
      this.errorText,
      required this.controller,
      this.keyboardType,
      this.readOnly = false,
      this.autoFocus = false,
      this.focusNode,
      this.onEditingComplete,
      this.onEditingTap,
      this.isAmountInput = false,
      this.validator,
      this.onChanged,
      this.isFormatterNeeded = true,
      super.key});
  final String labelText;
  final String? hintText;
  final String? errorText;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool autoFocus;
  final FocusNode? focusNode;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onEditingTap;
  final bool isAmountInput;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool isFormatterNeeded;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.7),
          suffixText: isAmountInput ? "VNĐ" : null,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 0.0,
            ),
          ),
          errorText: errorText,
        ),
        keyboardType: keyboardType,
        readOnly: readOnly,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        autofocus: autoFocus,
        focusNode: focusNode,
        onEditingComplete: onEditingComplete,
        textInputAction: TextInputAction.done,
        validator: validator,
        onChanged: onChanged,
        inputFormatters: isFormatterNeeded
            ? [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                FilteringTextInputFormatter.deny(RegExp(r'[^\w\s]')),
              ]
            : null,
        onTap: !readOnly
            ? null
            : () {
                //Todo: show list of bank
                FocusScope.of(context).unfocus();
                onEditingTap!();
              },
      ),
    );
  }
}
