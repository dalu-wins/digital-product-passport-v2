import 'package:digital_product_passport/src/faaast_flutter/models/aas_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:digital_product_passport/src/product/presentation/aas_element_screen.dart';
import 'package:flutter/material.dart';

class Submodel extends AASElement implements Comparable<Submodel> {
  final String? kind;
  final List<SubmodelElement> submodelElements;

  Submodel({
    required this.submodelElements,
    super.idShort,
    this.kind,
    super.id,
    super.displayName,
    super.description,
  });

  @override
  Widget display(BuildContext context) {
    submodelElements.sort();
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                super.getDisplayName(),
                softWrap: true,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AASElementListScreen(
                      elementName: super.getDisplayName(),
                      elements: submodelElements,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
    );
  }

  @override
  int compareTo(Submodel other) {
    return getDisplayName().compareTo(other.getDisplayName());
  }
}
