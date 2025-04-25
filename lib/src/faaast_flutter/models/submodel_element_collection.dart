import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:digital_product_passport/src/product/presentation/aas_element_screen.dart';
import 'package:flutter/material.dart';

class SubmodelElementCollection extends SubmodelElement {
  final List<SubmodelElement> value;

  SubmodelElementCollection({
    required this.value,
    super.idShort,
    super.displayName,
  });

  List<SubmodelElement> getSortedElements() {
    final sorted = [...value];
    sorted.sort((a, b) => a.compareTo(b));
    return sorted;
  }

  @override
  Widget display(BuildContext context) {
    value.sort();
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(super.getDisplayName()),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AASElementListScreen(
                      elementName: super.getDisplayName(),
                      elements: value,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.chevron_right),
            )
          ],
        ),
      ),
    );
  }

  @override
  int get sortOrder => 3;
}
