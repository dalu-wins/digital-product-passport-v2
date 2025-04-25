// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:digital_product_passport/src/faaast_flutter/models/aas_element.dart';

class SubmodelElement extends AASElement
    implements Comparable<SubmodelElement> {
  SubmodelElement({
    super.idShort,
    super.id,
    super.description,
    super.displayName,
  });

  /// Lower numbers come first
  int get sortOrder => 10; // Default lowest priority

  /// Optional: Fallback comparison for tiebreaking (e.g., by name)
  @override
  int compareTo(SubmodelElement other) {
    final orderCompare = sortOrder.compareTo(other.sortOrder);
    if (orderCompare != 0) return orderCompare;
    return getDisplayName().compareTo(other.getDisplayName());
  }
}
