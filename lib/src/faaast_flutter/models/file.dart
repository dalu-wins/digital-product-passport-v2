import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:flutter/material.dart';

class File extends SubmodelElement {
  final String? value;
  final String? contentType;

  File({
    super.idShort,
    super.id,
    this.value,
    this.contentType,
  });

  @override
  Widget display(BuildContext context) {
    if (value == null) return super.display(context);
    switch (contentType) {
      case 'image/jpeg':
        return displayImage(context);
      case 'text/xml':
        // TODO fix data on server
        return displayImage(context);
      case 'text/html':
        // TODO fix data on server
        return displayImage(context);

      default:
        return super.display(context);
    }
  }

  Widget displayImage(context) {
    return Image.network(
      value!,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Theme.of(context).colorScheme.errorContainer,
          child: Center(
            child: Text(
              'Failed to load image',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}
