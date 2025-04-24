class Product {
  final String id;
  final String idShort;
  final List<dynamic> submodels;
  Product({
    required this.id,
    required this.idShort,
    required this.submodels,
  });
  @override
  String toString() {
    return submodels.toString();
  }
}
