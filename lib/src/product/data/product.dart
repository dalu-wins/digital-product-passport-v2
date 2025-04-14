import 'package:digital_product_passport/src/product/data/information.dart';

class Product {
  final List<Uri> images;
  final List<Information> allInformation;
  final List<Information> keyInformation;
  Product({
    required this.images,
    required this.allInformation,
    required this.keyInformation,
  });
}
