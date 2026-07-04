import 'package:flutter/material.dart';
import 'package:stylo_app/core/constants/app_sizes.dart';

import 'package:stylo_app/features/more/presentation/widgets/labeled_text_field_widget.dart';

class PriceQuantityRowWidget extends StatelessWidget {
  final TextEditingController priceController;
  final TextEditingController quantityController;

  const PriceQuantityRowWidget({
    super.key,
    required this.priceController,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Price field
        Expanded(
          child: LabeledTextFieldWidget(
            label: 'Price (USD)',
            hint: '0.00',
            controller: priceController,
            keyboardType: TextInputType.number,
            prefixText: '\$ ',
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (double.tryParse(v) == null) return 'Invalid';
              return null;
            },
          ),
        ),
        SizedBox(width: AppSizes.md),
        // Quantity field
        Expanded(
          child: LabeledTextFieldWidget(
            label: 'Stock Quantity',
            hint: '10',
            controller: quantityController,
            keyboardType: TextInputType.number,
            validator: (v) {
              if (v == null || v.isEmpty) return 'Required';
              if (int.tryParse(v) == null) return 'Invalid';
              return null;
            },
          ),
        ),
      ],
    );
  }
}