import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';

import 'package:digital_product_passport/src/product/presentation/exceptions/invalid_url_exception.dart';
import 'package:digital_product_passport/src/product/presentation/exceptions/loading_exception.dart';
import 'package:flutter/material.dart';

// import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  final String url;

  const ProductScreen({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<String?> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadData(widget.url);
  }

  Future<String?> _loadData(String url) async {
    if (!isValidUrl(url)) return Future.error(InvalidUrlException(url));

    final uri = Uri.parse(url);

    // Deaktiviert die Zertifikatvalidierung (Achtung: Nur für Entwicklung!)
    final httpClient = HttpClient()
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) =>
              true; // Always trust the certificate

    final ioClient = IOClient(httpClient);

    try {
      final response = await ioClient.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Einfachheitshalber nur die ID-Shorts ausgeben
        final List<String> ids = [];

        if (data is Map && data['result'] is List) {
          for (var item in data['result']) {
            if (item is Map && item.containsKey('idShort')) {
              ids.add(item['idShort']);
            }
          }
        }

        return ids.toString();
      } else {
        return Future.error(LoadingException(response.statusCode.toString()));
      }
    } catch (e) {
      return Future.error(e);
    } finally {
      ioClient.close();
    }
  }

  // Future<String?> _loadData(String url) async {
  //   if (!isValidUrl(url)) return Future.error(InvalidUrlException(url));

  //   final uri = Uri.parse(url);

  //   try {
  //     final response = await http.get(uri); // Nutze den Standard-HTTP-Client

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);

  //       // Nur die idShorts extrahieren
  //       final List<String> ids = [];

  //       if (data is Map && data['result'] is List) {
  //         for (var item in data['result']) {
  //           if (item is Map && item.containsKey('idShort')) {
  //             ids.add(item['idShort']);
  //           }
  //         }
  //       }

  //       return ids.toString();
  //     } else {
  //       return Future.error(LoadingException(response.statusCode.toString()));
  //     }
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  bool isValidUrl(String url) {
    final urlPattern = r'^(https?:\/\/)?' // http:// oder https:// (optional)
        r'((([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,})|' // Domain (z.B. example.com)
        r'((\d{1,3}\.){3}\d{1,3}))' // oder IP-Adresse (z.B. 192.168.1.1)
        r'(:\d{1,5})?' // optionaler Port (z.B. :8080)
        r'(\/[^\s]*)?$'; // optionaler Pfad (z.B. /products/12)

    final regex = RegExp(urlPattern);
    return regex.hasMatch(url);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Screen'),
      ),
      body: FutureBuilder<String?>(
        future: _dataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            Navigator.pop(context);

            WidgetsBinding.instance.addPostFrameCallback((_) {
              final messenger = ScaffoldMessenger.of(context);
              messenger.hideCurrentSnackBar(); // Aktuelle SnackBar schließen
              messenger.showSnackBar(
                SnackBar(
                  content: Text(
                    snapshot.error.toString(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
              );
            });

            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Center(
              child: Text(
                snapshot.data.toString(),
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }
}
