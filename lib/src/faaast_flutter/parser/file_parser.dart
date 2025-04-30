import 'package:digital_product_passport/src/faaast_flutter/models/file.dart';

class FileParser {
  static File parse(Map fileToParse) {
    return File(
      idShort: fileToParse['idShort'],
      id: fileToParse['id'],
      value: fileToParse['value'],
      contentType: fileToParse['contentType'],
    );
  }
}
