import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:flutter/material.dart';

//TODO remove later, just for testing gpg sign

class Property extends SubmodelElement {
  final String? valueType;
  final String? value;

  Property({
    this.valueType,
    this.value,
    super.idShort,
    super.displayName,
  });

  @override
  Widget display(BuildContext context) {
    return Card.filled(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name
            Expanded(
              flex: 1,
              child: Text(
                super.getDisplayName(),
                softWrap: true,
              ),
            ),
            const SizedBox(width: 16),
            // Value
            Expanded(
              flex: 1,
              child: Text(
                value?.isNotEmpty == true ? value! : "no data",
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  int get sortOrder => 1;
}
