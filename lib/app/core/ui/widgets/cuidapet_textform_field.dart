import 'package:cuidapet_mobile/app/core/helpers/unfocus.dart';
import 'package:cuidapet_mobile/app/core/ui/extensions/theme_extension.dart';
import 'package:flutter/material.dart';

class CuidapetTextFormField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final Function(PointerDownEvent)? onTapOutSide;
  CuidapetTextFormField(
      {Key? key,
      required this.label,
      this.obscureText = false,
      this.controller,
      this.validator,
      this.textInputAction,
      this.onTapOutSide})
      : _obscureTextVN = ValueNotifier(obscureText),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _obscureTextVN,
        builder: (context, obscureTextVNvalue, child) {
          return TextFormField(
            textInputAction: textInputAction,
            controller: controller,
            validator: validator,
            obscureText: obscureTextVNvalue,
            onTapOutside: onTapOutSide ?? (_) => context.unFocus(),
            decoration: InputDecoration(
                labelText: label,
                labelStyle: const TextStyle(fontSize: 15, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.grey)),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Colors.red)),
                suffixIcon: obscureText
                    ? IconButton(
                        onPressed: () {
                          _obscureTextVN.value = !obscureTextVNvalue;
                        },
                        icon: Icon(
                          obscureTextVNvalue ? Icons.lock : Icons.lock_open,
                          color: context.primaryColor,
                        ),
                      )
                    : null),
          );
        });
  }
}
