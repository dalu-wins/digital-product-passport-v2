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
    var imagesSubmodel = getSubmodelByIdShort('Images');
    List<Widget> displayedElements = [];
    if (imagesSubmodel != null) {
      displayedElements = imagesSubmodel.submodelElements
          .map(
            (element) => element.display(context),
          )
          .toList();
    }

    ConstrainedBox images = ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 200),
      child: CarouselView(
        itemSnapping: true,
        itemExtent: 330,
        shrinkExtent: 200,
        children: displayedElements,
        onTap: (int index) {
          showDialog(
            context: context,
            builder: (_) => Dialog(
              backgroundColor: Colors.black,
              insetPadding: EdgeInsets.zero,
              child: InteractiveViewer(
                child: Center(
                  child: displayedElements[index],
                ),
              ),
            ),
          );
        },
      ),
    );

    submodels.sort();
    var submodelWidgets =
        submodels.map((submodel) => submodel.display(context)).toList();

    return Column(
      children: [
        images,
        ...submodelWidgets,
      ],
    );
  }

  Submodel? getSubmodelByIdShort(String targetIdShort) {
    try {
      return submodels
          .firstWhere((submodel) => submodel.idShort == targetIdShort);
    } catch (e) {
      return null; // if not found
    }
  }
}
