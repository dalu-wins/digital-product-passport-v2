import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/property_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_element_collection_parser.dart';

class SubmodelElementParser {
  static SubmodelElement parse(Map seToParse) {
    if (seToParse.containsKey('modelType')) {
      switch (seToParse['modelType']) {
        case 'SubmodelElementCollection':
          return SubmodelElementCollectionParser.parse(seToParse);
        case 'Property':
          return PropertyParser.parse(seToParse);
        default:
          return SubmodelElement(idShort: "idShort");
      }
    }
    return SubmodelElement(idShort: "idShort");
  }
}
