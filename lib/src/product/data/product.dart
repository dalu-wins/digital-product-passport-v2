import 'package:digital_product_passport/src/faaast_flutter/models/submodel.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String idShort;
  final List<Submodel> submodels;
  Product({
    required this.id,
    required this.idShort,
    required this.submodels,
  });
  Widget display(BuildContext context) {
    submodels.sort();
    var submodelWidgets =
        submodels.map((submodel) => submodel.display(context)).toList();
    return Column(
      children: submodelWidgets,
    );
  }
}
