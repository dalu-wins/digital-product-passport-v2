import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:flutter/material.dart';

class Property extends SubmodelElement {
  final String? valueType;
  final String? value;

  Property({
    this.valueType,
    this.value,
    super.idShort,
    super.displayName,
  });

  Widget getInformationText() {
    if (value == null) return Text("no data");
    if (value!.isEmpty) return Text("no data");
    return Text(value!);
  }

  @override
  Widget display(BuildContext context) {
    return Card.filled(
      color: Theme.of(context).colorScheme.secondaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              super.getDisplayName(),
            ),
            getInformationText()
          ],
        ),
      ),
    );
  }

  @override
  int get sortOrder => 1;
}
