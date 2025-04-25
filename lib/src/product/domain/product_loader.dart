import 'dart:convert';
import 'dart:io';

import 'package:digital_product_passport/src/faaast_flutter/models/submodel.dart';
import 'package:digital_product_passport/src/faaast_flutter/parser/submodel_parser.dart';
import 'package:digital_product_passport/src/product/data/product.dart';
import 'package:digital_product_passport/src/product/presentation/exceptions/loading_exception.dart';
import 'package:flutter/material.dart';
import 'package:http/io_client.dart';

class ProductLoader {
  Uri uri;
  ProductLoader({required this.uri});

  List<String> getEncodedSubmodelIds(Map shellData) {
    List<String> submodelIds = [];
    for (var entry in shellData['submodels']) {
      String id = entry['keys'][0]['value'].toString();
      submodelIds.add(base64.encode(id.codeUnits));
    }
    return submodelIds;
  }

  String getSubmodelPrefix() {
    return '${uri.scheme}://${uri.host}:${uri.port}/api/v3.0/submodels/';
  }

  Future<Map> getSubmodelData(Uri submodelUri) async {
    // Deaktiviert die Zertifikatvalidierung (Achtung: Nur für Entwicklung!)
    final httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Always trust the certificate

    final ioClient = IOClient(httpClient);

    try {
      final response = await ioClient.get(submodelUri);

      if (response.statusCode == 200) {
        final shellData = jsonDecode(response.body);
        return shellData;
      } else {
        return Future.error(LoadingException(response.statusCode.toString()));
      }
    } catch (e) {
      return Future.error(e);
    } finally {
      ioClient.close();
    }
  }

  Future<Product> loadProduct(BuildContext context) async {
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

        // get all submodel ids base64 encoded
        List<String> submodelIds = getEncodedSubmodelIds(shellData);

        // get full urls
        String prefix = getSubmodelPrefix();
        List<Uri> fullUrls =
            submodelIds.map((id) => Uri.parse('$prefix$id')).toList();

        // get submodel data
        List<dynamic> submodelData = await Future.wait(fullUrls
            .map((submodelUrl) => getSubmodelData(submodelUrl))
            .toList());

        List<Submodel> submodels = submodelData
            .map((submodel) => SubmodelParser.parse(submodel, context))
            .toList();

        return Product(
          id: shellData['id'],
          idShort: shellData['idShort'],
          submodels: submodels,
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
