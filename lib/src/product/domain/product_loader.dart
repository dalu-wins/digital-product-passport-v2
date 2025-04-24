import 'dart:convert';
import 'dart:io';

import 'package:digital_product_passport/src/product/data/product.dart';
import 'package:digital_product_passport/src/product/presentation/exceptions/loading_exception.dart';
import 'package:http/io_client.dart';

class ProductLoader {
  Uri uri;
  ProductLoader({required this.uri});

  Future<Product> loadProduct() async {
    // Deaktiviert die Zertifikatvalidierung (Achtung: Nur für Entwicklung!)
    final httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Always trust the certificate

    final ioClient = IOClient(httpClient);

    try {
      final response = await ioClient.get(uri);

      if (response.statusCode == 200) {
        final shellData = jsonDecode(response.body);

        // get all submodel ids
        List<String> submodelIds = [];
        for (var entry in shellData['submodels']) {
          submodelIds.add(entry['keys'][0]['value'].toString());
        }

        return Product(
          id: shellData['id'],
          idShort: shellData['idShort'],
          submodelIds: submodelIds,
        );
      } else {
        return Future.error(LoadingException(response.statusCode.toString()));
      }
    } catch (e) {
      return Future.error(e);
    } finally {
      ioClient.close();
    }
  }
}
