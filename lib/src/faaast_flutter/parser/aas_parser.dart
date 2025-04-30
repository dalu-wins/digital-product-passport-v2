import 'package:digital_product_passport/src/faaast_flutter/models/aas_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/file_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/multi_language_property_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/property_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_element_collection_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_parser.dart';
import 'package:flutter/material.dart';

class AASParser {
  AASElement parse(Map elementToParse, BuildContext context) {
    if (elementToParse.containsKey("modelType")) {
      switch (elementToParse['modelType']) {
        case 'Submodel':
          return SubmodelParser.parse(elementToParse, context);
        case 'SubmodelElementCollection':
          return SubmodelElementCollectionParser.parse(elementToParse, context);
        case 'Property':
          return PropertyParser.parse(elementToParse);
        case 'MultiLanguageProperty':
          return MultiLanguagePropertyParser.parse(elementToParse, context);
        case 'File':
          return FileParser.parse(elementToParse);
        default:
          return AASElement();
      }
    }
    return AASElement();
  }
}
