import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:flutter/material.dart';

class MultiLanguageProperty extends SubmodelElement {
  final List<Map<String, String>>? displayNames;
  final List<Map<String, String>>? values;
  final BuildContext context;

  MultiLanguageProperty({
    super.idShort,
    this.displayNames,
    this.values,
    required this.context,
  });

  @override
  String getDisplayName() {
    String languageCode = Localizations.localeOf(context).languageCode;
    String text = 'no name found';

    if (displayNames != null) {
      final localisedMap = displayNames!.firstWhere(
        (map) => map['language'] == languageCode,
        orElse: () {
          if (displayNames!.isNotEmpty) {
            return displayNames![0];
          } else {
            return {};
          }
        }, // fallback if not found
      );
      if (localisedMap.containsKey("text")) {
        text = localisedMap["text"]!;
      } else if (idShort != null) {
        text = splitCamelCase(idShort!);
      } else if (id != null) {
        text = id!;
      }
    } else if (idShort != null) {
      text = splitCamelCase(idShort!);
    } else if (id != null) {
      text = id!;
    }
    return text;
  }

  String getValue() {
    String languageCode = Localizations.localeOf(context).languageCode;
    String text = 'no value found';

    if (values != null) {
      final localisedMap = values!.firstWhere(
        (map) => map['language'] == languageCode,
        orElse: () {
          if (values!.isNotEmpty) {
            return values![0];
          } else {
            return {};
          }
        }, // fallback if not found
      );
      if (localisedMap.containsKey("text")) {
        text = localisedMap["text"]!;
      } else if (idShort != null) {
        text = splitCamelCase(idShort!);
      } else if (id != null) {
        text = id!;
      }
    } else if (idShort != null) {
      text = splitCamelCase(idShort!);
    } else if (id != null) {
      text = id!;
    }
    return text;
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
                getDisplayName(),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            ),
            const SizedBox(width: 16),
            // Value
            Expanded(
              flex: 1,
              child: Text(
                getValue(),
                style: TextStyle(color: Theme.of(context).colorScheme.tertiary),
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
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
