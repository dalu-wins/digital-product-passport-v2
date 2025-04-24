class Product {
  final String id;
  final String idShort;
  final List<dynamic> submodelIds;
  Product({
    required this.id,
    required this.idShort,
    required this.submodelIds,
  });
  @override
  String toString() {
    return submodelIds.toString();
  }
}
