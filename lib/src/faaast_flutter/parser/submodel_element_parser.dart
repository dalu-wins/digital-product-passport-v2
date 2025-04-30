import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/file_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/multi_language_property_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/property_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_element_collection_parser.dart';
import 'package:flutter/material.dart';

class SubmodelElementParser {
  static SubmodelElement parse(Map seToParse, BuildContext context) {
    if (seToParse.containsKey('modelType')) {
      switch (seToParse['modelType']) {
        case 'SubmodelElementCollection':
          return SubmodelElementCollectionParser.parse(seToParse, context);
        case 'Property':
          return PropertyParser.parse(seToParse);
        case 'MultiLanguageProperty':
          return MultiLanguagePropertyParser.parse(seToParse, context);
        case 'File':
          return FileParser.parse(seToParse);
        default:
          return SubmodelElement(displayName: seToParse['modelType']);
      }
    }
    return SubmodelElement();
  }
}
