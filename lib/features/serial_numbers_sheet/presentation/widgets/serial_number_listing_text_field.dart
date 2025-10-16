import 'package:flutter/material.dart';

import '../../../../core/constants/app_size.dart';
import '../../../widgets/app_text_form_field.dart';

class SerialNumberListingTextField extends StatefulWidget {
  const SerialNumberListingTextField({
    super.key,
    required this.index,
    required this.isAutoGenerateEnabled,
    required this.onChanged,
    required this.initialValue,
  });

  final int index;
  final bool isAutoGenerateEnabled;
  final Function(String value, int index) onChanged;
  final String initialValue;

  @override
  State<SerialNumberListingTextField> createState() =>
      _SerialNumberListingTextFieldState();
}

class _SerialNumberListingTextFieldState
    extends State<SerialNumberListingTextField> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("${widget.index + 1}"),
        SizedBox(width: AppSize.size10),
        Expanded(
          child: AppTextFormField(
            initialValue: widget.initialValue,
            readOnly: widget.isAutoGenerateEnabled,
            // enabled: false,
            filled: false,
            style: Theme.of(context).textTheme.titleMedium,
            onChanged: (value) {
              widget.onChanged(value, widget.index);
            },
          ),
        ),
      ],
    );
  }
}
