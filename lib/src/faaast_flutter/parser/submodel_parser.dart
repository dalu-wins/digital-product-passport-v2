import 'package:digital_product_passport/src/faaast_flutter/models/submodel.dart';
import 'package:digital_product_passport/src/faaast_flutter/models/submodel_element.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_element_parser.dart';
import 'package:flutter/material.dart';

class SubmodelParser {
  static Submodel parse(Map submodelToParse, BuildContext context) {
    List<SubmodelElement> submodelElements = [];
    if (submodelToParse['submodelElements'] is List) {
      for (var element in submodelToParse['submodelElements']) {
        submodelElements.add(SubmodelElementParser.parse(element, context));
      }
    }

    return Submodel(
      kind: submodelToParse['kind'],
      submodelElements: submodelElements,
      idShort: submodelToParse['idShort'],
    );
  }
}
