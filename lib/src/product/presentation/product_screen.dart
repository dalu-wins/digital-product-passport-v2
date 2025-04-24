import 'package:digital_product_passport/src/product/data/product.dart';
import 'package:digital_product_passport/src/product/domain/product_loader.dart';

import 'package:digital_product_passport/src/product/presentation/exceptions/invalid_url_exception.dart';
import 'package:digital_product_passport/src/product/presentation/widgets/qr_dialog.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

// import 'package:http/http.dart' as http;

class ProductScreen extends StatefulWidget {
  final String url;

  const ProductScreen({super.key, required this.url});

  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late Future<Product> _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = _loadProduct(widget.url);
  }

  Future<Product> _loadProduct(String url) async {
    if (!isValidUrl(url)) return Future.error(InvalidUrlException(url));

    final uri = Uri.parse(url);
    ProductLoader productLoader = ProductLoader(uri: uri);
    Future<Product> product = productLoader.loadProduct();
    return product;
  }

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
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return QrDialog(
                    url: widget.url,
                  );
                },
              );
            },
            icon: Icon(Icons.qr_code),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder<Product>(
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
                      //overflow: TextOverflow.ellipsis,
                    ),
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
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
      ),
    );
  }
}
