import 'package:digital_product_passport/src/faaast_flutter/models/aas_element.dart';
import 'package:flutter/material.dart';

class AASElementListScreen extends StatefulWidget {
  final String elementName;
  final List<AASElement> elements;

  const AASElementListScreen(
      {super.key, required this.elements, required this.elementName});

  @override
  State<StatefulWidget> createState() => _AASElementListScreenState();
}

class _AASElementListScreenState extends State<AASElementListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.elementName,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: displayContent(),
        ),
      ),
    );
  }

  Widget displayContent() {
    List<Widget> displayedElements =
        widget.elements.map((element) => element.display(context)).toList();
    if (widget.elementName == 'Images') {
      return ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 200),
        child: CarouselView(
            itemSnapping: true,
            itemExtent: 330,
            shrinkExtent: 200,
            children: displayedElements),
      );
    } else {
      return Column(
        children: displayedElements,
      );
    }
  }
}
