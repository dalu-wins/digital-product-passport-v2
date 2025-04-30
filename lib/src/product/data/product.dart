import 'package:digital_product_passport/src/faaast_flutter/models/submodel.dart';
import 'package:digital_product_passport/src/product/presentation/aas_element_screen.dart';
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
    return Column(
      spacing: 8,
      children: [
        buildImages(context),
        buildGeneralSection(context),
        buildDetailSection(context),
        buildAllSubmodelsCard(context),
      ],
    );
  }

  Widget buildImages(BuildContext context) {
    var imagesSubmodel = getSubmodelByIdShort('Images');
    List<Widget> displayedElements = [];
    if (imagesSubmodel != null) {
      displayedElements = imagesSubmodel.submodelElements
          .map(
            (element) => element.display(context),
          )
          .toList();
    }

    return ConstrainedBox(
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
  }

  // TODO Don't hardcode it
  Widget buildGeneralSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "General",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Card.outlined(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Manufacturer",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Manufacturer Name",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Model",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Model Name",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Type",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Product Type",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // TODO Don't hardcode it!
  Widget buildDetailSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Details",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
        Card.outlined(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Screen Size",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '6.3"',
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Battery Capacity",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "4000 mAh",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Battery Technology",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "LiPo",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Operating System",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "iOS 18.0.1",
                        softWrap: true,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAllSubmodelsCard(BuildContext context) {
    submodels.sort();
    return Card.outlined(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                "All Submodels",
                softWrap: true,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AASElementListScreen(
                      elementName: "All Submodels",
                      elements: submodels,
                    ),
                  ),
                );
              },
              icon: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
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
