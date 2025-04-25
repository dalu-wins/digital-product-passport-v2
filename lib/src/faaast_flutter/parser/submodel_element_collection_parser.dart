import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element_collection.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_element_parser.dart';

class SubmodelElementCollectionParser {
  static SubmodelElementCollection parse(Map secToParse) {
    List<SubmodelElement> submodelElements = [];
    if (secToParse['value'] is List) {
      for (var element in secToParse['value']) {
        submodelElements.add(SubmodelElementParser.parse(element));
      }
    }

    return SubmodelElementCollection(
      value: submodelElements,
      idShort: secToParse['idShort'],
    );
  }
}
