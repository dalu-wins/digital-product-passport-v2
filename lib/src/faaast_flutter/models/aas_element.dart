import 'package:flutter/material.dart';

class AASElement {
  final String? id;
  final String? idShort;
  final String? description;
  final String? displayName;

  AASElement({
    this.id,
    this.idShort,
    this.description,
    this.displayName,
  });

  String getDisplayName() {
    String text = 'no name found';
    if (displayName != null) {
      text = displayName!;
    } else if (idShort != null) {
      text = idShort!;
    } else if (id != null) {
      text = id!;
    }
    return text;
  }

  Widget display(BuildContext context) {
    return Card(
      child: Text(getDisplayName()),
    );
  }
}
