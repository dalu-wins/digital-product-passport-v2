import 'package:digital_product_passport/src/faaast_flutter/models/multi_language_property.dart';
import 'package:flutter/material.dart';

class MultiLanguagePropertyParser {
  static MultiLanguageProperty parse(Map mlpToParse, BuildContext context) {
    final List<Map<String, String>> displayNames = [];
    if (mlpToParse['displayName'] is List) {
      for (var entry in mlpToParse['displayName']) {
        if (entry is Map &&
            entry['language'] != null &&
            entry['text'] != null) {
          displayNames.add({
            'language': entry['language'].toString(),
            'text': entry['text'].toString(),
          });
        }
      }
    }

    final List<Map<String, String>> values = [];
    if (mlpToParse['value'] is List) {
      for (var entry in mlpToParse['value']) {
        if (entry is Map &&
            entry['language'] != null &&
            entry['text'] != null) {
          values.add({
            'language': entry['language'].toString(),
            'text': entry['text'].toString(),
          });
        }
      }
    }

    return MultiLanguageProperty(
      idShort: mlpToParse['idShort'],
      displayNames: displayNames,
      values: values,
      context: context,
    );
  }
}
