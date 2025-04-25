import 'package:digital_product_passport/src/faaast_flutter/models/aas_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/property_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_element_collection_parser.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_parser.dart';

class AASParser {
  AASElement parse(Map elementToParse) {
    if (elementToParse.containsKey("modelType")) {
      switch (elementToParse['modelType']) {
        case 'Submodel':
          return SubmodelParser.parse(elementToParse);
        case 'SubmodelElementCollection':
          return SubmodelElementCollectionParser.parse(elementToParse);
        case 'Property':
          return PropertyParser.parse(elementToParse);
        default:
          return AASElement();
      }
    }
    return AASElement();
  }
}
