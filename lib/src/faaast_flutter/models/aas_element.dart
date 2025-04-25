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

  String splitCamelCase(String input) {
    // if (input.isEmpty || input[0] != input[0].toUpperCase()) {
    //   return input; // bleibt unverändert wenn mit lowercase anfängt
    // }
    return input.replaceAllMapped(
      RegExp(r'(?<=[a-z])(?=[A-Z])'),
      (match) => ' ',
    );
  }

  String getDisplayName() {
    String text = 'no name found';
    if (displayName != null) {
      text = displayName!;
    } else if (idShort != null) {
      text = splitCamelCase(idShort!);
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
