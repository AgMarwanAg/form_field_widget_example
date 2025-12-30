import 'package:flutter/material.dart';

class FormFieldWidget<T> extends FormField<T> {
  FormFieldWidget({
    super.key,
    super.initialValue,
    super.enabled,
    super.validator,
    super.onSaved,
    required Widget Function(FormFieldState<T> state) builder,
    BorderRadius? borderRadius,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12),
    Color borderColor = Colors.grey,
    Color errorBorderColor = Colors.red,
  }) : super(
         builder: (state) {
           final hasError = state.hasError;

           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             mainAxisSize: MainAxisSize.min,
             children: [
               Container(
                 padding: padding,
                 decoration: BoxDecoration(
                   borderRadius: borderRadius ?? BorderRadius.circular(12),
                   border: Border.all(
                     color: hasError ? errorBorderColor : borderColor,
                   ),
                 ),
                 child: builder(state),
               ),
               if (hasError)
                 Padding(
                   padding: const EdgeInsets.only(top: 4),
                   child: Text(
                     state.errorText!,
                     style: const TextStyle(color: Colors.red),
                   ),
                 ),
             ],
           );
         },
       );
}