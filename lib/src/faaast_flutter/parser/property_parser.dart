import 'package:digital_product_passport/src/faaast_flutter/models/property.dart';

class PropertyParser {
  static Property parse(Map propertyToParse) {
    return Property(
      valueType: propertyToParse['valueType'],
      value: propertyToParse['value'],
      idShort: propertyToParse['idShort'],
    );
  }
}
