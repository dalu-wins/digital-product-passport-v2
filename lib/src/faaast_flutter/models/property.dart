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

  Widget getInformationText(BuildContext context) {
    return Text(
      value?.isNotEmpty == true ? value! : "no data",
      style: TextStyle(color: Theme.of(context).colorScheme.primary),
      maxLines: 10,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.end,
    );
  }

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
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            ),
            const SizedBox(width: 16),
            // Value
            Expanded(
              flex: 1,
              child: getInformationText(context),
            ),
          ],
        ),
      ),
    );
  }

  @override
  int get sortOrder => 1;
}
